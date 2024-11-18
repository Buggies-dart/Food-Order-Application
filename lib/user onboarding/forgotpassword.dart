import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/firebase%20auth/user_auth.dart';
import 'package:food_delivery_app/user%20onboarding/login.dart';
import 'package:food_delivery_app/utils.dart';
class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController controller = TextEditingController();
void resetPassword() async{
 await FirebaseAuthMethods(FirebaseAuth.instance).resetPassword(email: controller.text, context: context);
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: Colors.black,
      body: SafeArea(child: 
      Center(
        child: Column(
          children: [
          const  SizedBox( height: 20,),
         Row(
           children: [
            IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
         const LoginUI()));
            }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),),
           SizedBox( width: MediaQuery.of(context).size.width/8),
         const Text('Recover Password', style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
              ),),
           ],
         ),
         const SizedBox( height: 20),
            Text('Enter your email address', style: AppWidget.buttonText(),),
           const SizedBox(height: 40,),
            Padding( 
              padding: const EdgeInsets.all(8.0),
              child: TextField( controller: controller, style: const TextStyle(color: Colors.white),
                decoration: InputDecoration( focusedBorder:  OutlineInputBorder(
                  borderSide:const BorderSide( color: Colors.white),  borderRadius: BorderRadius.circular(25),
                ),
              hintText: 'Email', prefixIcon: const Icon(Icons.person), hintStyle: const TextStyle( fontSize: 16, color: Colors.white),
                border: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(25),
                       )
                       ),
                       ),
            ),
        const SizedBox( height: 30),
        SizedBox(  height: 55,
      width: MediaQuery.of(context).size.width / 1.06,
          child: ElevatedButton(onPressed: resetPassword,
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ), 
            ),
             child: Text('Send Email', style: AppWidget.mediumfontBold(),), ),
        )  
          ],
        ),
      )
      ),
    );
  }
}