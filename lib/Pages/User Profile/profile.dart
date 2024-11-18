import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

   final displayNameHeader =  usernameAsyncValue.when(data: (username){
            if (username != null) {
         return Center(child: Text(username, style: AppWidget.userNameText())) ; } else { return const Text('');
            }
          }, error:(error, _) => Text('Error: $error'),  loading: ()=> const CircularProgressIndicator.adaptive()
          );
  
   final displayName =  usernameAsyncValue.when(data: (username){
            if (username != null) {
         return Text(username, style: AppWidget.lightFont2()) ; } else { return const Text('');
            }
          }, error:(error, _) => Text('Error: $error'),  loading: ()=> const CircularProgressIndicator.adaptive()
          );
  void deleteAccount ()async{
await FirebaseAuthMethods(FirebaseAuth.instance).deleteAccount(context);
  }  
void signOut() async{
    await FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
  }
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

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
    decoration: BoxDecoration( color: ShowColors.secondary(), borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105),
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
        CircleAvatar(  radius: 60,
         backgroundImage:  FileImage(selectedImage!),
   ): CircleAvatar(  radius: 60,
                          child: Icon(MdiIcons.camera),
      ),
                         ),
                  ),
                ),
 
          ],
            ),
        const SizedBox( height: 60),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( 
             leading: const Icon(Icons.person), title: Text('Name', style: AppWidget.lightFont2(),), subtitle: displayName
             ),
          ),
        ),
       const SizedBox( height: 25,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( 
             leading: const Icon(Icons.email), title: Text('Email', style: AppWidget.lightFont2(),), 
             subtitle: displayEmail
             ),
          ),
        ), 
       const SizedBox( height: 25,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( 
             leading: const Icon(Icons.email), title: Text('Delivery Address', style: AppWidget.lightFont2(),), 
             subtitle: displayEmail
             ),
          ),
        ), 
       const SizedBox( height: 25,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( 
             leading: const Icon(Icons.email), title: Text('Terms and Conditions', style: AppWidget.lightFont2(),), 
             ),
          ),
        ), 
       const SizedBox( height: 25,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( onTap: deleteAccount,
             leading: const Icon(Icons.delete), title: Text('Delete Account', style: AppWidget.lightFont2(),), 
            subtitle: null, ),
          ),
        ),
       const SizedBox( height: 25,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Material( elevation: 2, shadowColor: Colors.black, borderRadius: BorderRadius.circular(15),
            child:  ListTile( onTap: signOut,
             leading: const Icon(Icons.logout), title: Text('Sign Out', style: AppWidget.lightFont2(),), 
             ),
          ),
        ) 
        ]
        ),
      ),
    );
  }
}
