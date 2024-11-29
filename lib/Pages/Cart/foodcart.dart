import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';

class FoodCart extends ConsumerStatefulWidget {
  const FoodCart({super.key});

  @override
  ConsumerState<FoodCart> createState() => _OrderpageState();
}

class _OrderpageState extends ConsumerState<FoodCart> {
  @override
  Widget build(BuildContext context) {
  final cartInfo = ref.watch(Providers.myNotifProvider).cart;
  final wallet = ref.watch(Providers.myNotifProvider).wallet;
  final purchase = ref.read(Providers.myNotifProvider);
  final addToOrders = ref.read(Providers.myNotifProvider);
  final double totalPrice = cartInfo.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar( centerTitle: true,
        title: Text('Food Cart', style: AppWidget.largefontBold(),),
      ),
  body: cartInfo.isEmpty? Center(child: Text('Your Cart Is Empty', style: AppWidget.mediumfontBold(),)) 
  :Column(
    children: [ Expanded( child: ListView.builder( itemCount: cartInfo.length, itemBuilder: (context, index){
     final cart = cartInfo[index];
  void tap (){showDialogBox(context, (){ 
  ref.read(Providers.myNotifProvider).firestoreCartRemove(cart['name'], context);
  ref.read(Providers.myNotifProvider).removeCart(cart);
  Navigator.pop(context);
   }, (){Navigator.pop(context);}, 'Remove Product', 'Proceed with action?');  }
       return SizedBox( height: 140,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card( color: Colors.white, elevation: 5,
            child: Row( 
              children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(color: null, height: 30, width: 30, decoration: BoxDecoration(
                border: Border.all( width: 2), borderRadius: BorderRadius.circular(10)
              ),
                child:  Center(child: Text(cart['quantity'].toString())),),
            ), 
             SizedBox( width: MediaQuery.of(context).size.width/25,),
         CircleAvatar( backgroundImage: NetworkImage(cart['image']),
            radius: MediaQuery.of(context).size.height/20,),
           SizedBox( width: MediaQuery.of(context).size.width/15,),
            Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cart['name'], style: AppWidget.mediumfontBold(),), 
                Text('\$${cart['price']}'.toString(), style: AppWidget.mediumfontBold(),),
              ],
            ),
            const Spacer(),
             IconButton(onPressed: tap, icon: const Icon(Icons.delete, color: Colors.red,))
              ],
            ),
          ),
        ),
      );
    }),
  ),
 
 Padding(
   padding: const EdgeInsets.only( bottom: 50),
   child: Column(
     children: [
       Container( height: 50,
         decoration: BoxDecoration( border: Border.all( width: 1, color: Colors.black26),
       color: null,), 
       child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row( 
          children: [
          Text('Total Price', style: AppWidget.mediumfontBold(),),
          const Spacer(),
          Text( totalPrice.toStringAsFixed(2), style: AppWidget.mediumfontBold())
          ],
        ),
       ),
       ),
    const SizedBox( height: 10),
   SizedBox( width: MediaQuery.of(context).size.width/1.1, height: 60,
    child: ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: ShowColors.primary(),
    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10))),
      onPressed: (){
        showDialogBox(context, (){
      if (wallet >= totalPrice) {
    
  purchase.removeWallet(totalPrice);
  addToOrders.addToOrders(cartInfo);
    Navigator.pop(context); cartInfo.clear();
    showOrderConfirmationDialog();
      } else {
      showSnackbar(context, 'Insufficient Balance, Top Up and Try Again');
      Navigator.pop(context);
      }

        }, (){Navigator.pop(context);}, 'Make Payment', '\$${totalPrice.toStringAsFixed(2)} will be deducted from your wallet, kindly confirm if you\'d like to pay' );
      }, child:  Text('CheckOut', style: AppWidget.userNameText(),)
      )
      ) ],
   ),
 ),

    ],
  ),
  );
  }

void showOrderConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: ShowColors.primary(),
              size: 80,
            ),
            const SizedBox(height: 16),
           const  Text(
              'Hiyya! Your order is on the way to your delivery address.',
              style:  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          const  Text(
              'You should get your orders within 45 minutes.',
              style:  TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

}