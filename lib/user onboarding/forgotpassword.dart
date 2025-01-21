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
    final theme = Theme.of(context);
    return  Scaffold( backgroundColor: theme.scaffoldBackgroundColor,
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
            }, icon:  const Icon(Icons.arrow_back_ios, color: secondaryContainer),),
           SizedBox( width: MediaQuery.of(context).size.width/8),
         Text('Recover Password', style: theme.textTheme.displayLarge
              ),
           ],
         ),
         const SizedBox( height: 20),
            Text('Enter your email address', style: theme.textTheme.displayMedium,),
           const SizedBox(height: 40,),
            Padding( 
              padding: const EdgeInsets.all(8.0),
              child: TextField( controller: controller, style: TextStyle(color: theme.primaryColor, fontSize: 16),
                decoration: InputDecoration( focusedBorder:  OutlineInputBorder(
                  borderSide:const BorderSide( color: Colors.white),  borderRadius: BorderRadius.circular(40),
                ),
              hintText: 'Email', prefixIcon: navIconGradient( const Icon(Icons.person, size: 35, color: whiteColor,)), hintStyle: const TextStyle( fontSize: 16, color: Colors.white),
                border: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(25),
                       )
                       ),
                       ),
            ),
        const SizedBox( height: 30),
        SizedBox(  height: 55,
      width: MediaQuery.of(context).size.width / 1.06,
          child: GestureDetector(  onTap: resetPassword, 
        child: Container( 
decoration: BoxDecoration( gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
borderRadius: BorderRadius.circular(15)),
child: Center(child: Text('LOGIN', style: AppWidget.buttonText())),),
      ),
        )  
          ],
        ),
      )
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