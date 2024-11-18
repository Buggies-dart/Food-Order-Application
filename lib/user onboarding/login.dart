import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/firebase%20auth/user_auth.dart';
import 'package:food_delivery_app/user%20onboarding/forgotpassword.dart';
import 'package:food_delivery_app/user%20onboarding/signup.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
TextEditingController controllerMail = TextEditingController();
TextEditingController controllerPass = TextEditingController();
 bool isLoading = false;
 bool showPassword = false;
@override
  void dispose() {
    super.dispose();
    controllerMail; controllerPass;
  }
  void signup (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
    { return const SignUp();}));
  }
 void resetPassword(){
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return const Forgotpassword();
  }));
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      body: isLoading == true ? const 
      Center(child:  CircularProgressIndicator.adaptive()) :
      Stack(
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
        top: MediaQuery.of(context).size.height/5
       ),
         child: Row( mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Text('Don\'t have an account?', style: AppWidget.mediumfontBold(),),
             TextButton(onPressed: signup, child: Text('Sign Up', style: AppWidget.mediumfontBold(),))
           ],
         ),
       ), ), 
        Center(child: SizedBox( height: MediaQuery.of(context).size.height/1.7, width: 400,
          child: Card(  color: Colors.white, shadowColor: Colors.black, elevation: 10,
          
          margin: EdgeInsets.only( bottom:  MediaQuery.of(context).size.height/11),
                  
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text('Login', style: AppWidget.largefontBold()),
             const SizedBox( height: 10,),
            loginFields(Icons.mail, 'Email', controllerMail),
            loginFields(Icons.password, 'Password', controllerPass),
           Align( alignment: Alignment.centerRight,
             child: Padding(
               padding: const EdgeInsets.only(right: 15),
               child: TextButton(onPressed: resetPassword, child:  Text('Forgot Password?', style: AppWidget.mediumfontBold(),
               ), )
               
             ),
           ),
          const Spacer(),
           Padding(
             padding: const EdgeInsets.all(30),
             child: loginButton(()async{
              setState(() {
             isLoading = true;

            });
           await FirebaseAuthMethods(FirebaseAuth.instance).userSignin(mail: controllerMail.text, password: controllerPass.text, context: context);
           setState(() {
         isLoading = false; });
             }),
           ) 
           ],
          ),
        ),          ),
        )
        )
        ],
      ),
    );
  }

 Widget loginButton(onTap) {
    return SizedBox( width: MediaQuery.of(context).size.width/1.3,
      child: ElevatedButton(
        onPressed: onTap, 
                       style:  ElevatedButton.styleFrom( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              minimumSize: const Size(80, 50), backgroundColor: ShowColors.primary()
             ),
             child: Text('LOGIN', style: AppWidget.buttonText(),),),
    );
  }

  Widget loginFields(IconData icon, String hint, TextEditingController textController) {
    return Padding(
          padding: const EdgeInsets.all(20),
          child:  TextField( controller: textController, obscureText: hint == 'Password' && showPassword == false? true : false,
            decoration: InputDecoration( prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(icon), 
            ), 
            hintText: hint, hintStyle:const TextStyle( fontWeight: FontWeight.bold),
            hoverColor: Colors.black, 
            suffixIcon: hint == 'Password' ? IconButton(onPressed: (){
           setState(() {
             showPassword = true;
           });
            }, icon: showPassword == false?
            Icon(MdiIcons.eyeLock):Icon(MdiIcons.eyeCheck))
           :null ),
          ),
        );
  }
}