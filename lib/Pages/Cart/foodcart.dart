import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
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
  final sizeHeight = MediaQuery.of(context).size.height;
  final sizeWidth = MediaQuery.of(context).size.width;
  final ThemeData theme = Theme.of(context);
  final cartInfo = ref.watch(Providers.myNotifProvider).cart;
  final wallet = ref.watch(Providers.myNotifProvider).wallet;
  final purchase = ref.read(Providers.myNotifProvider);
  final addToOrders = ref.read(Providers.myNotifProvider);
  final double totalPrice = cartInfo.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

void checkOutFunction  (){
  showDialogBox(context, (){
   if (wallet >= totalPrice) { purchase.removeWallet(totalPrice); addToOrders.addToOrders(cartInfo);
  Navigator.pop(context); cartInfo.clear();
  showOrderConfirmationDialog();
  } else {
  showSnackbar(context, 'Insufficient Balance, Top Up and Try Again');
  Navigator.pop(context);
   }
  }, (){Navigator.pop(context);}, 'Make Payment', '\$${totalPrice.toStringAsFixed(2)} will be deducted from your wallet, kindly confirm if you\'d like to pay' );
  }
return Scaffold( 
backgroundColor: theme.scaffoldBackgroundColor, 
  
  body: cartInfo.isEmpty? Stack(
    children: [ Column(
      children: [
    appBar(sizeHeight, context, sizeWidth, theme, 'Food Cart', (){ Navigator.pop(context);
      }),
     Padding(
     padding: EdgeInsets.only(top: sizeHeight/2.5),
     child: Center(child: Text('Your Cart Is Empty', style: theme.textTheme.displayMedium,)),
     ),
      ],
    ),
  backgroundImage('assets/logos/backgroundimg.png')]
  ) 
  : Stack(
    children:[
Column(
      children: [
  appBar(sizeHeight, context, sizeWidth, theme, 'Food Cart', (){ Navigator.pop(context);
      }),
  Expanded( child: ListView.builder( itemCount: cartInfo.length,  padding: const EdgeInsets.only(top: 0), itemBuilder: (context, index){
       final cart = cartInfo[index];
    void tap (){showDialogBox(context, (){ 
    ref.read(Providers.myNotifProvider).firestoreCartRemove(cart['name'], context);
    ref.read(Providers.myNotifProvider).removeCart(cart);
    Navigator.pop(context);
     }, (){Navigator.pop(context);}, 'Remove Product', 'Proceed with action?');  }
         return SizedBox( height: sizeHeight/7,
    child: Padding(
    padding: const EdgeInsets.all(5),
    child: SizedBox( 
    child: Card( color: theme.colorScheme.primaryContainer,
    child: Row( 
     children: [
     Padding( padding: const EdgeInsets.all(10),
    child: Container( height: 30, width: 30, decoration: BoxDecoration(
    border: Border.all( width: 2, color:theme.primaryColor), borderRadius: BorderRadius.circular(10)
    ),
      child:  Center(child: Text(cart['quantity'].toString(), style: TextStyle(color: theme.primaryColor),)),
    ),
    ), 
    SizedBox( width: MediaQuery.of(context).size.width/25,),
    CircleAvatar( backgroundImage: NetworkImage(cart['image']),
    radius: MediaQuery.of(context).size.height/20,),
    SizedBox( width: MediaQuery.of(context).size.width/15,),
    Column( mainAxisAlignment: MainAxisAlignment.center,
     children: [
    Text(cart['name'], style: theme.textTheme.displayMedium,), 
    const  SizedBox(height: 3,),
    Text('\$${cart['price']}'.toString(), style: theme.textTheme.displayMedium,),
     ],
    ),
    const Spacer(),
    IconButton(onPressed: tap, icon:  const Icon(Icons.delete, color: tertiaryContainer,))
     ],
    ),
    ),
    ),
    ),
    );
    }),
    ),
     
    Stack(
      children: [ Padding( padding: const EdgeInsets.all(10), child: Container( height: sizeHeight/3.3, width: double.infinity,
         decoration: BoxDecoration(gradient: LinearGradient(colors: [ShowColors.primary(),
       ShowColors.secondary()])
      ,borderRadius: BorderRadius.circular(30)),
      child: Padding( padding: const EdgeInsets.only( bottom: 50),
      child: Column(
             children: [
         Container( height: sizeHeight/6, decoration: BoxDecoration( border: Border.all( width: 0, color: Colors.black26),
         color: null), 
         child: Padding( padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
         child: Column(
           children: [
             foodPrices(theme, totalPrice, const Text('Sub Total', style: TextStyle( color: whiteColor, fontSize: 16)), 
            const TextStyle( color: whiteColor, fontSize: 16), totalPrice.toStringAsFixed(2)),
             foodPrices(theme, totalPrice, const Text('Delivery Charge', style: TextStyle( color: whiteColor, fontSize: 16)), 
            const TextStyle( color: whiteColor, fontSize: 16), '0.00'),
             foodPrices(theme, totalPrice, const Text('Discount', style: TextStyle( color: whiteColor, fontSize: 16)), 
             const TextStyle( color: whiteColor, fontSize: 16), '0.00'),
             SizedBox( height: sizeHeight/22),
             foodPrices(theme, totalPrice, const Text('Total Price', style: TextStyle( color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold),), 
             const TextStyle( color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold), totalPrice.toStringAsFixed(2)),
           ],
         ),
         ),
         ),
         SizedBox( height: sizeHeight/60,),
         SizedBox( width: MediaQuery.of(context).size.width/1.1, height: sizeHeight/15,
         child: GestureDetector( onTap: checkOutFunction,
           child: Container(  decoration: BoxDecoration( color: whiteColor, borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text('CheckOut', style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold,
      foreground: Paint()..shader = LinearGradient( colors: [ShowColors.primary(), ShowColors.secondary()],
      begin: Alignment.topLeft, end: Alignment.bottomRight,).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      ),
      ))
      ),
      )
      ) ],
      ),
      ),
       ),
      ),
      Positioned.fill(child: backgroundImage('assets/logos/backgroundimg2.png'))
      ]),
    ],
    ),
  backgroundImage('assets/logos/backgroundimg.png')
]
  ),
  );
  }


Row foodPrices(ThemeData theme, double totalPrice, Widget text, TextStyle textStyle, String price) {
    return Row( 
 children: [ text,
 const Spacer(),
 Text( '\$$price', style: textStyle)
 ],
 );
  }

void showOrderConfirmationDialog() {
showDialog( context: context, builder: (BuildContext context) {
return AlertDialog( shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20),
),
content:  Column( mainAxisSize: MainAxisSize.min,
children: [ Icon( Icons.check_circle, color: ShowColors.primary(), size: 80,),
const SizedBox(height: 16),
const  Text( 'Hiyya! Your order is on the way to your delivery address.',
style:  TextStyle( fontSize: 18,
fontWeight: FontWeight.bold,), textAlign: TextAlign.center,
),const SizedBox(height: 8),
const  Text( 'You should get your orders within 45 minutes.',
style:  TextStyle(fontSize: 16), textAlign: TextAlign.center,
),
 ],
),
actions: [ TextButton( onPressed: () { Navigator.of(context).pop();
},
child: const Text('Close'),
),
],
);
},
);
}

}