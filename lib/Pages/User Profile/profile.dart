import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/User%20Profile/t_and_c.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/firebase%20auth/user_auth.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
 
  @override
  Widget build(BuildContext context) {
   final usernameAsyncValue = ref.watch(Providers.userProvider);
   final emailAsyncValue = ref.watch(Providers.mailProvider);
   final addressAsyncValue = ref.watch(Providers.addressProvider);

  final displayEmail = emailAsyncValue.when(
  data: (email) {
    if (email != null) {
      return Text(email, style: AppWidget.lightFont2());
    } else {
      return const Text('');
    }
  },
  error: (error, _) => Text('Error: $error'),
  loading: () => const Text(''),
);
 final ImagePicker picker = ImagePicker();
File? selectedImage;
TextEditingController password = TextEditingController();
TextEditingController addressChanged = TextEditingController();

final displayNameHeader =  usernameAsyncValue.when(data: (username){
if (username != null) {
return Center(child: Text(username, style: AppWidget.userNameText())) ; } else { return const Text('');
}
}, error:(error, _) => Text('Error: $error'),  loading: ()=> const Text('')
);
  
final displayName =  usernameAsyncValue.when(data: (username){
if (username != null) {
return Text(username, style: AppWidget.lightFont2()) ; } else { return const Text('');
}
}, error:(error, _) => Text('Error: $error'),  loading: ()=> const Text('')
);
  
final displayAddress =  addressAsyncValue.when(data: (email){
if (email != null) {
return Text(email, style: AppWidget.lightFont2()) ; } else { return const Text('');
}
}, error:(error, _) => Text('Error: $error'),  loading: ()=> const Text('')
);
 
 
  void deleteAccount ()async{
await FirebaseAuthMethods(FirebaseAuth.instance).deleteAccount(context);
  }  

void signOut() async{
  try {
  await FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
  ref.read(Providers.myNotifProvider).resetState();
  ref.invalidate(Providers.userProvider);
    ref.invalidate(Providers.mailProvider);

  } catch (e) {
    if(context.mounted){
  showSnackbar(context, 'An unexpected error occured, try again later.');

    }
  }
  }
 
void changeAddress(){
  dialogPopUp(password, () async{
   Navigator.pop(context);
 await FirebaseAuthMethods(FirebaseAuth.instance).confirmPassword(context, password.text, addressChanged);
  });
}

Future getImage()async{
   var image = await picker.pickImage(source: ImageSource.gallery);
  if ( image != null) {
    setState(() {
    selectedImage = File(image.path);
  });
  } 
}

    return Scaffold(
      body: Center(
   child: Column(   children: [  Stack( clipBehavior: Clip.none, alignment: Alignment.center, 
       children: [
   Container(width: double.infinity, height: MediaQuery.of(context).size.height/4,
    decoration: BoxDecoration( color: ShowColors.secondary(), borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width/3.5 ),
        ),
                  ),
    child: displayNameHeader,),
                Positioned(
        top: MediaQuery.of(context).size.height/ 5.6, // Adjust this value to control the avatar's height
                  child: GestureDetector( onTap: (){
           getImage();
                  },
    child: Material( elevation: 10, shape: const CircleBorder(),
                         child: selectedImage != null? 
        CircleAvatar(  radius: MediaQuery.of(context).size.width/7.5,
         backgroundImage:  FileImage(selectedImage!),
   ): CircleAvatar(  radius: MediaQuery.of(context).size.width/7.5,
                          child: Icon(MdiIcons.camera),
      ),
                         ),
                  ),
                ),
    
          ],
            ),
SizedBox( height: MediaQuery.of(context).size.height/14),
SingleChildScrollView( scrollDirection: Axis.vertical,
child: Column( 
children: [
Padding(
padding: const EdgeInsets.only(left: 20, right: 20),
child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
child:  ListTile( 
leading: navIconGradient(const Icon(Icons.person, color: whiteColor,)), title: Text('Name', style: AppWidget.lightFont2(),), subtitle: displayName
),
),
),
           
SizedBox( height: MediaQuery.of(context).size.height/35,),
 Padding(
 padding: const EdgeInsets.only(left: 20, right: 20),
child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
child:  ListTile( 
leading: navIconGradient( const Icon(Icons.email, color: whiteColor,)), title: Text('Email', style: AppWidget.lightFont2(),), 
subtitle: displayEmail
),
),
), 
 SizedBox( height: MediaQuery.of(context).size.height/35,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
              child:  ListTile( 
               leading: navIconGradient(const Icon(Icons.location_city, color: whiteColor,)), title: Text('Delivery Address', style: AppWidget.lightFont2(),), 
               subtitle: displayAddress,
               trailing: TextButton(onPressed: changeAddress, child:  const Text('Change', style: TextStyle(color: secondaryColor),)), ),
            ),
          ), 
SizedBox( height: MediaQuery.of(context).size.height/35,),
Padding(
padding: const EdgeInsets.only(left: 20, right: 20),
child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
child:  ListTile(  onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context){
return const TermsAndConditionsPage();
}));
},
leading: navIconGradient(Icon(MdiIcons.pen, color: whiteColor)), title: Text('Terms and Conditions', style: AppWidget.lightFont2(),), 
               ),
            ),
          ), 
               SizedBox( height: MediaQuery.of(context).size.height/35,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
              child:  ListTile( onTap: deleteAccount,
               leading: navIconGradient( const Icon(Icons.delete, color: whiteColor,)), title: Text('Delete Account', style: AppWidget.lightFont2(),), 
              subtitle: null, ),
            ),
          ),
               SizedBox( height: MediaQuery.of(context).size.height/35,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
              child:  ListTile( onTap: signOut,
               leading: navIconGradient(const Icon(Icons.logout, color: whiteColor,)), title: Text('Sign Out', style: AppWidget.lightFont2(),), 
               ),
            ),
          ) 
           ],
          ),
        ),
        ]
        ),
      ),
    );
  }
  void dialogPopUp(TextEditingController password, VoidCallback ontap){
  showDialog(context: context, builder: (context){
    return  AlertDialog.adaptive(elevation: 5, backgroundColor: Colors.white, title: Center(child: Text('Confirm Your Password', style: AppWidget.mediumfontBold(),)),
    content: SizedBox( height: MediaQuery.of(context).size.height/5, 
      child: Column(
        children: [
          TextField(
          controller: password, decoration: const InputDecoration(
         prefixIcon: Icon(Icons.password), hoverColor: Colors.black
          ),
         ),
         const SizedBox( height: 50),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox( height: 50, width: MediaQuery.of(context).size.width/2,
              child: ElevatedButton( style: ElevatedButton.styleFrom(  backgroundColor: ShowColors.primary(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),),
                onPressed: ontap, child: Text('Done', style: AppWidget.buttonText(),)),
            ),
          )
        ],
      ),
    ),);
  });
 }


}
