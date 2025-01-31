import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/MapBox%20API/mapbox.dart';
import 'package:food_delivery_app/firebase%20auth/user_auth.dart';
import 'package:food_delivery_app/user%20onboarding/Login.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
bool showPassword = false;
final TextEditingController controllerName = TextEditingController();
final TextEditingController controllerMail = TextEditingController();
final TextEditingController controllerPass = TextEditingController();
final TextEditingController addressController = TextEditingController();
List<String> suggestions = [];
bool showSuggestions = false;


@override
  void dispose() {
    super.dispose();
    controllerName; controllerMail; controllerPass; addressController; 
  }

  void logIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const LoginUI();
    }));
  }
 
 Future<void>getUserAddress(String query)  async{

if (query.isNotEmpty) {
final data =  await getLocation(context, query);

if (data != null && data['features'] != null) {
setState(() {
suggestions = (data['features'] as List).map((feature) {
final String place = feature['place_name'] as String;
final contextDetails = feature['context'] as List<dynamic>?;
final city = contextDetails?.firstWhere(
(item) => item['id'].toString().startsWith('place'),
orElse: () => null
)?['text'] ??
'';
showSuggestions = true;
  return '$place, $city';
}).toList();
});
}

} else {
setState(() {
 suggestions;
 showSuggestions = false;
  }); 
}
}

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
return Scaffold( 
body: Stack(
children: [
Container( width: MediaQuery.of(context).size.width, 
height: MediaQuery.of(context).size.height / 2,
decoration:   BoxDecoration(
gradient: LinearGradient(colors: [
ShowColors.primary(),  ShowColors.secondary()
],
begin: Alignment.topCenter, end: Alignment.bottomLeft)
),
child: Padding(
padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/5),
 child: Image.asset('assets/logos/halle_dining.png'),
), ),
Container( 
margin: EdgeInsets.only( top: MediaQuery.of(context).size.height/3 ),
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
decoration: BoxDecoration( color: theme.colorScheme.primaryContainer,
borderRadius:BorderRadius.circular(50)
),
child: Padding( padding: EdgeInsets.only(
top: MediaQuery.of(context).size.height/4
),
child: Row( mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Already have an account?', style: theme.textTheme.displayMedium,),
TextButton(onPressed: logIn, child: Text('Log In', style: theme.textTheme.displayMedium,))
],
),
), ), 
Stack(
  children: [ Center(child: SizedBox( height: MediaQuery.of(context).size.height/1.5, width: 400,
  child: Padding(
  padding: const EdgeInsets.only(top: 20),
  child: Card(  color: theme.colorScheme.primaryContainer, shadowColor: Colors.black, elevation: 10,
  margin: EdgeInsets.only( bottom:  MediaQuery.of(context).size.height/11),
                      
  child: Padding(
  padding: const EdgeInsets.only(top: 20), child: Column(
  children: [
  Text('Sign Up', style: AppWidget.largefontBold()),
  signUpFields(Icons.person, 'Name', controllerName),
  signUpFields(Icons.mail, 'Email', controllerMail),
  signUpFields(Icons.password, 'Password', controllerPass),
  signUpFields(Icons.home, 'Enter Your Home Address', addressController),

const Align( alignment: Alignment.centerRight,
  child: Padding(
  padding: EdgeInsets.only(right: 15),
  ),
  ),
  const Spacer(),
  Padding( padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
  child: signupButton(()async{
  await FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(username: controllerName.text, mail: controllerMail.text, password: controllerPass.text, context: context, address: addressController.text);
  }),
  ) 
  ],
  ),
  ),),
  ),
  )
  ),
  showSuggestions && suggestions.isNotEmpty?
Positioned( top: MediaQuery.of(context).size.height/1.65, left: MediaQuery.of(context).size.width/8.2,
child: Center(
  child: Material( elevation: 5, shadowColor: blackColor,
    child: Container(  width: MediaQuery.of(context).size.width/1.3, color: theme.colorScheme.primaryContainer, 
     child: 
     SizedBox( height:  MediaQuery.of(context).size.height/3,
      child: ListView.builder( padding: const EdgeInsets.only(top: 0),
    itemCount: suggestions.length, itemBuilder: (context, index){
    return  ListTile( onTap: (){
     setState(() {
    addressController.text = suggestions[index];
    if (addressController.text == suggestions[index]) {
    showSuggestions = false;
    suggestions.clear();
    }
    else{ showSuggestions; suggestions;}
     }); 
    
    },
    title: Text(suggestions[index], style: theme.textTheme.displaySmall),
    );
    })
    )
     ),
  ),
),
)
: const Text('')])
],
 ),
);
}

 Widget signupButton(VoidCallback onTap) {

 return SizedBox( width: MediaQuery.of(context).size.width / 1.3, height: MediaQuery.of(context).size.height/20,
      child:GestureDetector(  onTap: onTap, 
        child: Container( 
decoration: BoxDecoration( gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
borderRadius: BorderRadius.circular(15)),
child: Center(child: Text('SIGN UP', style: AppWidget.buttonText())),),
      ),
            );
    
  }
  Padding signUpFields(IconData icon, String hint, TextEditingController textController) {
return Padding( padding: const EdgeInsets.all(20),
child:  TextField( controller: textController,  style:  Theme.of(context).textTheme.displaySmall,
onChanged: hint == 'Enter Your Home Address'? (value)=> getUserAddress(value) : null,
obscureText: hint == 'Password' && showPassword == false? true : false,
decoration: InputDecoration( prefixIcon: Padding(
padding: const EdgeInsets.only(bottom: 8),
child: navIconGradient(Icon(icon, color: whiteColor,)), 
),
  hintText: hint, hintStyle: 
TextStyle( fontWeight: FontWeight.bold, fontSize: 16 , color: Theme.of(context).colorScheme.secondaryContainer),
hoverColor: Colors.black, suffixIcon: hint == 'Password' ?
IconButton(onPressed: (){
setState(() {
showPassword = true;
});
}, icon: showPassword == false?
navIconGradient(Icon(MdiIcons.eyeLock, color: whiteColor,)):navIconGradient(Icon(MdiIcons.eyeCheck, color: whiteColor,))) 
:null),
),
);
}
Widget navIconGradient(Widget nav){
return ShaderMask( shaderCallback: (Rect bounds) {
 return  LinearGradient(
colors:  [ShowColors.primary(), ShowColors.secondary()],
begin: Alignment.topLeft,
end: Alignment.topRight,
).createShader(bounds);
},
child: nav);
  }
}