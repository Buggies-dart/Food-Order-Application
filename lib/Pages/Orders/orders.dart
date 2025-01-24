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
 int productCount = 1;
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
              SizedBox( width: sizeWidth/10),
    Column( mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container( color: null, width: sizeWidth/4.3, height: sizeHeight/40,
    child: Text( cart['name'].toString().length < 10 || cart['name'].toString().length ==  10 ?
      cart['name'] : '${cart['name'].toString().substring(0, 8)}...', style:  theme.textTheme.displayMedium,)
    ), 
    Text(cart['category'], style: theme.textTheme.displaySmall),
    Text('\$${cart['price'].toString()}', style: TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, foreground: Paint() ..shader =  LinearGradient(
    colors: [ShowColors.primary(), ShowColors.secondary()], begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    )),
     ],
     ),
Padding(
padding: EdgeInsets.only(left: sizeWidth/10),
child: GestureDetector( onTap:  (){
final totalCharge = cart['price'] * productCount;
dialog(cart['image'], cart['name'], cart['category'],
productCount,
(){
  Navigator.pop(context);
showDialogBox(context, (){
    if (wallet >= cart['price']) { purchase.removeWallet(totalCharge); 
  Navigator.pop(context);
  showOrderConfirmationDialog(context);
  } else {
  showSnackbar(context, 'Insufficient Balance, Top Up and Try Again');
  Navigator.pop(context);
   }
}, (){
  
  Navigator.pop(context);}, 'Make Payment', '\$${totalCharge.toStringAsFixed(2)} will be deducted from your wallet, kindly confirm if you\'d like to pay');
});

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
 ref.read(Providers.myNotifProvider).firestoreClearOrders(context);
setState(() {
cartInfo.clear(); 
        });
      Navigator.pop(context);
      }, (){Navigator.pop(context);}, 'Clear Order History', 'This action can\'t be undone, proceed?');
      }, child:  const Text('Clear', style: TextStyle(color: secondaryContainer),)),
    );
  }

  void dialog( String img, String name, String category, int addProduct, VoidCallback order){
showDialog(context: context, builder: (context){
return StatefulBuilder
(
  builder: (context, setDialogState)=> AlertDialog.adaptive(
  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  
  icon: CircleAvatar( radius: 45, child: Image.network(img)), 
  
  title: Column(
    children: [
      Text(name, style:  Theme.of(context).textTheme.displayMedium),
      Text(category, style:  Theme.of(context).textTheme.displaySmall),
      const Divider( thickness: 0.2),
    ],
  ),
  actions: [
   GestureDetector( onTap: (){
setDialogState (() {
    addProduct++ ;                  
}); 
setState(() {
  
});
  },
    child: Container( height: MediaQuery.of(context).size.height/25, width: MediaQuery.of(context).size.width/12,
   decoration: BoxDecoration(gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
    borderRadius: BorderRadius.circular(10)),
      child: const Icon(Icons.add, color: whiteColor,)
    ),
  ),
  Text(addProduct.toString(), style: Theme.of(context).textTheme.displaySmall,),
  
  GestureDetector( onTap: (){
  setDialogState (() {
  addProduct == 1 ? 1 :
    addProduct-- ;                  
}); 
setState(() {
  
});
  },
    child: Container( height: MediaQuery.of(context).size.height/25, width: MediaQuery.of(context).size.width/12,
  decoration: BoxDecoration(gradient: addProduct == 1 ? const LinearGradient(colors: [Colors.grey, Colors.grey])  : LinearGradient(colors:  [ShowColors.primary(), ShowColors.secondary()]),
    borderRadius: BorderRadius.circular(10)),
      child: const Icon(Icons.remove, color: whiteColor,)
      ),
  ),
  
   Padding(
      padding: const EdgeInsets.only(left: 30),
      child: GestureDetector( onTap: order,
        child: Container( width: MediaQuery.of(context).size.width/4.5, height: MediaQuery.of(context).size.height/25,
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
        gradient:   LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()])
        ),
        child: const Center(child:  Text('Order', style: TextStyle( color: whiteColor, fontSize: 20),)),
        ),
      ),
    ),
  
  ],
  ),
);
});
  }
}