import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final cartInfo = ref.watch(Providers.myNotifProvider).order;
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar( centerTitle: true,
        title: Text('Order History', style: AppWidget.largefontBold(),),
      ),
  body: cartInfo.isEmpty? Center(child: Text('No Orders Yet, Buy Some Meals.', style: AppWidget.mediumfontBold(),)) 
  :Column(
    children: [ Expanded( child: ListView.builder( itemCount: cartInfo.length, itemBuilder: (context, index){
     final cart = cartInfo[index];
       return SizedBox( height: 120,
        child: Padding( padding: const EdgeInsets.only(top: 10),
          child: Card( color: const Color.fromARGB(255, 156, 155, 155), elevation: 2,
            child: Row( 
              children: [
             const SizedBox( width: 15,),
                   CircleAvatar( backgroundImage: AssetImage(cart['image']),
            radius: 45,),
           const SizedBox( width: 50,),
            Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cart['name'], style: AppWidget.mediumfontBold(),), 
                Text(cart['category'], style: AppWidget.mediumfontBold(),),
              ],
            ),
              ],
            ),
          ),
        ),
      );
    }),
  ),
 
    ],
  ),
  );
  }
}