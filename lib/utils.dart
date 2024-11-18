import 'package:flutter/material.dart';
// TextStyles
class AppWidget{
  static TextStyle mediumfontBold(){
return const TextStyle(
 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
);
  }
 static TextStyle largefontBold(){
  return const TextStyle(
   fontSize: 30, fontWeight: FontWeight.bold
 );
 }
 static TextStyle lightFont(){
  return const TextStyle(
            fontSize: 18
          );
 }
 static TextStyle lightFont2(){
  return const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold
          );
 }
 static TextStyle buttonText(){
  return const TextStyle(
 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
);
 }
 static TextStyle userNameText(){
  return const TextStyle( fontSize: 25, fontWeight: FontWeight.bold,
  color: Colors.white);
 }
 }
// Colors
class ShowColors{
  static Color primary(){
    return const Color.fromARGB(255, 200, 81, 3);
  }
  static Color secondary(){
    return const Color.fromARGB(255, 245, 193, 116);
  }

}