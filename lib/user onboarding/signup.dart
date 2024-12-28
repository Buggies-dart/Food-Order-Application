import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

@override
  void dispose() {
    super.dispose();
    controllerName; controllerMail; controllerPass;
  }

  void logIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const LoginUI();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
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
          margin: EdgeInsets.only( top: 
          MediaQuery.of(context).size.height/3 ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration( color: Colors.white,
            borderRadius:BorderRadius.circular(50)
          ),
       child: Padding( padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height/4
       ),
         child: Row( mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Text('Already have an account?', style: AppWidget.mediumfontBold(),),
             TextButton(onPressed: logIn, child: Text('Log In', style: AppWidget.mediumfontBold(),))
           ],
         ),
       ), ), 
        Center(child: SizedBox( height: MediaQuery.of(context).size.height/1.5, width: 400,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Card(  color: Colors.white, shadowColor: Colors.black, elevation: 10,
            
            margin: EdgeInsets.only( bottom:  MediaQuery.of(context).size.height/11),
                    
                    child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text('Sign Up', style: AppWidget.largefontBold()),
               signUpFields(Icons.person, 'Name', controllerName),
              signUpFields(Icons.mail, 'Email', controllerMail),
              signUpFields(Icons.password, 'Password', controllerPass),
              signUpFields(Icons.home, 'Enter Your TX, Houston Home Address', addressController),
            const Align( alignment: Alignment.centerRight,
               child: Padding(
                 padding: EdgeInsets.only(right: 15),
                    
               ),
             ),
            const Spacer(),
             Padding(
               padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
               child: signupButton(()async{
             await FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(username: controllerName.text, mail: controllerMail.text, password: controllerPass.text, context: context, address: addressController.text);
              }),
             ) 
             ],
            ),
                    ),          ),
          ),
        )
        )
        ],
      ),
    );
  }

 Widget signupButton(VoidCallback onTap) {

    return SizedBox( width: MediaQuery.of(context).size.width / 1.3,
      child: ElevatedButton(onPressed: onTap, 
                       style:  ElevatedButton.styleFrom( backgroundColor: ShowColors.primary(),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              minimumSize: const Size(80, 50)
             ),
             child:  Text('SIGN UP', style: AppWidget.buttonText(),))
            );
    
  }
  Padding signUpFields(IconData icon, String hint, TextEditingController textController) {
    return Padding(
          padding: const EdgeInsets.all(20),
          child:  TextField( controller: textController,  
          obscureText: hint == 'Password' && showPassword == false? true : false,
            decoration: InputDecoration( prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(icon), 
            ),
            hintText: hint, hintStyle:const TextStyle( fontWeight: FontWeight.bold),
            hoverColor: Colors.black, suffixIcon: hint == 'Password' ?
            IconButton(onPressed: (){
           setState(() {
             showPassword = true;
           });
            }, icon: showPassword == false?
            Icon(MdiIcons.eyeLock):Icon(MdiIcons.eyeCheck)) 
            :null),
          ),
        );
  }
}