import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrderpageState();
}

class _OrderpageState extends ConsumerState<Orders> {
  @override
  Widget build(BuildContext context) {
  final sizeHeight = MediaQuery.of(context).size.height;
  final sizeWidth = MediaQuery.of(context).size.width;
  final ThemeData theme = Theme.of(context);
  final cartInfo = ref.watch(Providers.myNotifProvider).order;
  final wallet = ref.watch(Providers.myNotifProvider).wallet;
  final purchase = ref.read(Providers.myNotifProvider);


  return Scaffold( backgroundColor:  theme.scaffoldBackgroundColor,
  
body: cartInfo.isEmpty? Stack(
  children: [ Column(
      children: [ appBar(sizeHeight, context, sizeWidth, theme, 'Order History',  (){ 
Navigator.push(context, MaterialPageRoute(builder: (context){
return const Navigation();
}));
      }),
        Padding(
          padding:  EdgeInsets.only(top: sizeHeight/2.5),
          child: Center(child: Text('No Orders Yet, Buy Some Meals.', style: theme.textTheme.displayMedium,)),
        ),
      ],
    ),
 backgroundImage('assets/logos/backgroundimg.png')]
 ) 
  : Stack(
    children: [ Column( 
    children: [ Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ appBar(sizeHeight, context, sizeWidth, theme, 'Order History',  (){ Navigator.push(context, MaterialPageRoute(builder: (context){
return const Navigation();
    }));
      }),
     clearOrderHistory(context, cartInfo)
    ],
      ),
    Expanded( child: ListView.builder( itemCount: cartInfo.length, padding: const EdgeInsets.only(top: 10), itemBuilder: (context, index){
       final cart = cartInfo[index];
         return SizedBox( height: 120,
          child: Padding( padding: const EdgeInsets.only(top: 10),
            child: Card( color: theme.colorScheme.primaryContainer,
              child: Row( 
                children: [
               const SizedBox( width: 15,),
                     CircleAvatar( backgroundImage: NetworkImage(cart['image']),
              radius: 45,),
             const SizedBox( width: 50,),
    Column( mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container( color: null, width: sizeWidth/4.3, height: sizeHeight/40,
    child: Text( cart['name'].toString().length < 10 || cart['name'].toString().length ==  10 ?
      cart['name'] : '${cart['name'].toString().substring(0, 8)}...', style:  theme.textTheme.displayMedium,)
    ), 
    Text(cart['category'], style: theme.textTheme.displaySmall),
    Text('\$${cart['price'].toString()}', style: TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, foreground: Paint() ..shader =  LinearGradient(
    colors: [ShowColors.primary(), ShowColors.secondary()], begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    )),
     ],
     ),
Padding(
padding: EdgeInsets.only(left: sizeWidth/10),
child: GestureDetector( onTap:  (){
showDialogBox(context, (){
    if (wallet >= cart['price']) { purchase.removeWallet(cart['price']); 
  Navigator.pop(context);
  showOrderConfirmationDialog();
  } else {
  showSnackbar(context, 'Insufficient Balance, Top Up and Try Again');
  Navigator.pop(context);
   }
}, (){Navigator.pop(context);}, 'Make Payment', '\$${cart['price'].toStringAsFixed(2)} will be deducted from your wallet, kindly confirm if you\'d like to pay');
},
  child: Container( height: sizeHeight/22, width: sizeWidth/3.7, decoration: BoxDecoration(gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
  borderRadius: BorderRadius.circular(10)),
  child: const Center(
   child:  Text('Order Again', style: TextStyle( fontSize: 18, color: whiteColor
        ),),
       )),
),
     )   
             ],
              ),
            ),
          ),
        );
      }),
    ),
     
      ],
    ),
    backgroundImage('assets/logos/backgroundimg.png')]
  ),
  );
  }

  Widget clearOrderHistory(BuildContext context, List<Map<String, dynamic>> cartInfo) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/28),
      child: TextButton(onPressed: (){
      showDialogBox(context, (){
      cartInfo.clear(); 
      Navigator.pop(context);
      }, (){Navigator.pop(context);}, 'Clear Order History', 'This action can\'t be undone, proceed?');
      }, child:  const Text('Clear', style: TextStyle(color: secondaryContainer),)),
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