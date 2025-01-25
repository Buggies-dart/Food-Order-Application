import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';

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
// User Address
  static final addressProvider = FutureProvider<String?>((ref) async {
  final userId = FirebaseAuth.instance.currentUser?.uid; 
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userDoc.exists) {
    return userDoc.data()?['address'] as String?;
  } else {
    throw Exception('User not found');
  }
});

//  Add To Cart, Orders
static final myNotifProvider = ChangeNotifierProvider<StateProvider>((ref)=> StateProvider());

}

class StateProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> order = [];
  double wallet = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? userId = FirebaseAuth.instance.currentUser;

  // Save the current state to Firestore
 Future<void> saveStateToFirestore() async {
  if (userId == null || userId!.isAnonymous) {
    return;
  }
  try {
    await _firestore.collection('users').doc(userId?.uid).set({
      'cart': cart,
      'order': order,
      'wallet': wallet,
    }, SetOptions(merge: true)); // Merge existing fields
  } catch (e) {
return;  }
}

  Future<void> loadStateFromFirestore() async {
    if (userId == null) return;

    try {
      final snapshot = await _firestore.collection('users').doc(userId?.uid).get();
      if (snapshot.exists) {
        final data = snapshot.data()!;
        cart = List<Map<String, dynamic>>.from(data['cart'] ?? []);
        order = List<Map<String, dynamic>>.from(data['order'] ?? []);
        wallet = (data['wallet'] ?? 0).toDouble();
 notifyListeners();
      }
    } catch (e) {
    return;
    }
  }
  // Delete Cart Item From FireStore
  Future<void> firestoreCartRemove(String productName, BuildContext context) async {
  try {
    // Get the user's cart document
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId?.uid);

    // Fetch the current cart data
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      List<dynamic> cart = userSnapshot.get('cart');

      // Filter out the product to remove
      cart.removeWhere((product) => product['name'] == productName);

      // Update Firestore with the new cart
      await userRef.update({'cart': cart});
    
    } 
  } catch (e) {
    if (context.mounted) {
  showSnackbar(context, 'An unexpected error occurred, try again');
    }
 }
}
  Future<void> firestoreClearOrders(BuildContext context) async {
  try {
    // Get the user's cart document
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId?.uid);

    // Fetch the current cart data
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      List<dynamic> order = userSnapshot.get('order');
      // Filter out the product to remove
      order.clear();

      // Update Firestore with the new cart
      await userRef.update({'order': order});
    
    } 
  } catch (e) {
    if (context.mounted) {
  showSnackbar(context, 'An unexpected error occurred, try again');
    }
 }
}

  void addToCart(Map<String, dynamic> food) {
    cart.add(food);
    notifyListeners();
    saveStateToFirestore();
  }

  void removeCart(Map<String, dynamic> food) {
    cart.remove(food);
    notifyListeners();
  }

  void addToOrders(List<Map<String, dynamic>> food) {
    order.addAll(food);
    notifyListeners();
    saveStateToFirestore();
  }
void increaseQuantity(String id){
    var priceQuantity = order.firstWhere((foodProduct)=> foodProduct['name'] == id);
    
  priceQuantity['quantity']++;
    notifyListeners();
}
void reduceQuantity(String id){
  var priceQuantity = order.firstWhere((foodProduct)=> foodProduct['name'] == id);
  if (priceQuantity['quantity'] == 1) {
  1;
  } else {
     priceQuantity['quantity'] --;
  }
  notifyListeners();
}
  
int getQuantity(String id) {
    var foodProduct = order.firstWhere((foodProduct) => foodProduct['name'] == id, orElse: () => {'quantity': 0});
    return foodProduct['quantity'];
  }

  void addWallet(double amount) {
    wallet += amount;
    notifyListeners();
    saveStateToFirestore();
  }

  void removeWallet(double price) {
    wallet -= price;
    notifyListeners();
    saveStateToFirestore();
  }
  // Sign Out Data
  void resetState() {
  cart.clear();
  order.clear();
  wallet = 0;
  notifyListeners();
}

}
