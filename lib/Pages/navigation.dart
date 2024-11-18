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
      bottomNavigationBar: CurvedNavigationBar( onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      }, animationDuration: const Duration(milliseconds: 500), height: 65, backgroundColor: Colors.white,
       index: currentIndex, color: ShowColors.primary(),
        items: const [
        Icon(Icons.home, size: 30,), Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 30,), 
    Icon(Icons.wallet_outlined, color: Colors.black, size: 30,), Icon(Icons.person_outlined, color: Colors.black, size: 30,)
      ],),
    );
  }
}