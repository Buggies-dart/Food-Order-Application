import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
// UserName

static final userProvider = FutureProvider<String?>((ref) async {
  final userId = FirebaseAuth.instance.currentUser?.uid; 
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userDoc.exists) {
    return userDoc.data()?['username'] as String?;
  } else {
    throw Exception('');
  }
});
  
// User Email

  static final mailProvider = FutureProvider<String?>((ref) async {
  final userId = FirebaseAuth.instance.currentUser?.uid; 
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userDoc.exists) {
    return userDoc.data()?['email'] as String?;
  } else {
    throw Exception('User not found');
  }
});
//  Add To Cart, Orders
static final myNotifProvider = ChangeNotifierProvider<StateProvider>((ref)=> StateProvider());

}

class StateProvider extends ChangeNotifier{
List<Map<String, dynamic>> cart = [];
List<Map<String, dynamic>> order = [];
double wallet = 10;


void addToCart(Map<String, dynamic> food){
cart.add(food);
notifyListeners();
}
void removeCart(Map<String, dynamic> food){
cart.remove(food);
notifyListeners();
}

void addToOrders(List<Map<String, dynamic>> food){
order.addAll(food);
notifyListeners();
}
void addWallet(double amount) {
  wallet += amount;
  notifyListeners();
}

 void removeWallet( double price){
wallet -= price;
notifyListeners();
 }
}