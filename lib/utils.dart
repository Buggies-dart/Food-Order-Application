import 'package:flutter/material.dart';

const blackColor = Colors.black;
const whiteColor = Colors.white;
const secondaryColor = Color(0xFFDA6317);
const secondaryContainer = Color(0xFFFF9012);
const tertiaryContainer = Color(0xFFFEAD1D);
const whiteColor2 = Colors.white60;

class Palette{
  static var darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: blackColor,
  primaryColor: whiteColor,
  colorScheme:  ColorScheme.dark(
 onPrimary: ShowColors.primary(),
  onSecondary: ShowColors.secondary(),
  primaryContainer:  const Color(0xFF252525),
  secondaryContainer: whiteColor,
  onSecondaryContainer:  const Color(0xFF252525),
  ),
  textTheme: const TextTheme(
  displayLarge: TextStyle(
   fontSize: 30, fontWeight: FontWeight.bold
 ),
  bodyLarge: TextStyle(
   fontSize: 27, fontWeight: FontWeight.bold
 ),
  displayMedium: TextStyle(
 fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor
),
displaySmall: TextStyle(
fontSize: 18, color: whiteColor),
 bodySmall:  TextStyle(
  fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor, height: 2
),
titleLarge: TextStyle( fontSize: 25, fontWeight: FontWeight.bold,
  color: Colors.white)
  )
  );

  static var lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFFFAFDFF),
  primaryColor: blackColor,
  colorScheme:  ColorScheme.light(
    onPrimary: ShowColors.primary(),
  onSecondary: ShowColors.secondary(),
    primaryContainer: Colors.white,
   secondaryContainer:const Color(0xFFDA6317),
  onSecondaryContainer:  const Color.fromARGB(255, 250, 215, 176)

  ),
  textTheme: const TextTheme(
  displayLarge: TextStyle(
   fontSize: 30, fontWeight: FontWeight.bold, color: blackColor
 ),
  bodyLarge: TextStyle(
   fontSize: 27, fontWeight: FontWeight.bold
 ),
 displayMedium: TextStyle(
 fontSize: 20, fontWeight: FontWeight.bold, color: blackColor, 
),
displaySmall: TextStyle(
fontSize: 18, color: blackColor, height: 2),
 bodySmall:  TextStyle(
  fontSize: 18, fontWeight: FontWeight.bold, color: blackColor
),
titleLarge: TextStyle( fontSize: 25, fontWeight: FontWeight.bold,
  color: Colors.white),
 
 ),

);
}
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
    return const Color(0xFF53E88B);
  }
  static Color secondary(){
    return const Color(0xFF15BE77);
  }
}

class ThemeModeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void switchTheme(){
    if (themeMode == ThemeMode.light) {
    themeMode = ThemeMode.dark;
    }
    else if(themeMode == ThemeMode.dark){
  themeMode = ThemeMode.light;
    }
notifyListeners();  }
}