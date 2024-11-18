import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/firebase%20auth/user_auth.dart';
import 'package:food_delivery_app/user%20onboarding/forgotpassword.dart';
import 'package:food_delivery_app/user%20onboarding/signup.dart';
import 'package:food_delivery_app/utils.dart';

class AdminLogin extends ConsumerStatefulWidget {
  const AdminLogin({super.key});

  @override
  ConsumerState<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends ConsumerState<AdminLogin> {
TextEditingController controllerMail = TextEditingController();
TextEditingController controllerPass = TextEditingController();
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
          MediaQuery.of(context).size.height/2.1 ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration( color: Colors.white,
            borderRadius:BorderRadius.circular(25)
          ),
       child: Padding( padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height/5
       ),
       ), ), 
        Center(child: SizedBox( height: MediaQuery.of(context).size.height/1.7, 
        width: MediaQuery.of(context).size.width/1.2,
          child: Card(  color: Colors.white, shadowColor: Colors.black, elevation: 10,
          
          margin: EdgeInsets.only( bottom:  MediaQuery.of(context).size.height/10),
                  
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text('Admin Login', style: AppWidget.largefontBold()),
             const SizedBox( height: 10,),
            loginFields(Icons.person, 'Username', controllerMail),
            loginFields(Icons.password, 'Password', controllerPass),
           const Align( alignment: Alignment.centerRight,
             child: Padding(
               padding: EdgeInsets.only(right: 15),   
             ),
           ),
          const SizedBox( height: 10,),
           Padding(
             padding: const EdgeInsets.all(30),
             child: loginButton(() async{ 
            await  FirebaseAuthMethods(FirebaseAuth.instance).adminLogin(controllerMail.text, controllerPass.text, context);
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
          child:  TextField( controller: textController, obscureText: hint == 'Password'? true : false,
            decoration: InputDecoration( prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(icon), 
            ), 
            hintText: hint, hintStyle:const TextStyle( fontWeight: FontWeight.bold),
            hoverColor: Colors.black ),
          ),
        );
  }
}