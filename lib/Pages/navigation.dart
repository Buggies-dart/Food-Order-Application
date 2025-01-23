import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/Home/homepage.dart';
import 'package:food_delivery_app/Pages/Orders/orders.dart';
import 'package:food_delivery_app/Pages/User%20Profile/profile.dart';
import 'package:food_delivery_app/Pages/Wallet/walletpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:food_delivery_app/utils.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
 
 }

class _NavigationState extends State<Navigation> {
  List<Widget> navbars =  [
  const Homepage(), const Orders(), const Wallet(), const ProfilePage()
 ];
 int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: navbars[currentIndex],
      bottomNavigationBar: Container(
 decoration: const BoxDecoration(
boxShadow: [
BoxShadow( color: Color.fromARGB(51, 134, 133, 133), 
blurRadius: 5, offset: Offset(0, -1), 
),
],
),
        child: CurvedNavigationBar( onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },animationDuration: const Duration(milliseconds: 500), height: 65, backgroundColor: Colors.transparent,
         index: currentIndex, color: Theme.of(context).colorScheme.primaryContainer, 
          items:  [
        navIconGradient(  Icon(Icons.home, color: whiteColor, size: currentIndex == 0 ? 40 : 30,), 0), 
        navIconGradient( Icon(Icons.shopping_bag_outlined, color: whiteColor, size: currentIndex == 1 ? 40 : 30), 1),
           navIconGradient(  Icon(Icons.wallet_outlined, color: whiteColor, size: currentIndex == 2 ? 40 : 30), 2), 
           navIconGradient(  Icon(Icons.person_outlined,  color: whiteColor, size: currentIndex == 3 ? 40 : 30), 3) 
        ],),
      ),
    );
  }
  Widget navIconGradient(Widget nav, int index){
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