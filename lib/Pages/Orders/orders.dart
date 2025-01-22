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
    Text(cart['name'], style: theme.textTheme.displayMedium,), 
    Text(cart['category'], style: theme.textTheme.displaySmall,),
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
     child: Container( height: sizeHeight/22, width: sizeWidth/3.7, decoration: BoxDecoration(gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
     borderRadius: BorderRadius.circular(10)),
     child: const Center(
      child:  Text('Order Again', style: TextStyle( fontSize: 18, color: whiteColor
      ),),
     )),
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
}