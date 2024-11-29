import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails({super.key,  required this.foodInfos});
final  Map<String, dynamic> foodInfos;

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}
class _ProductDetailsState extends ConsumerState<ProductDetails> {
  void onTap(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
    return const Navigation();
    }));
  }

 @override
  Widget build(BuildContext context) {
  final cartProvider = ref.read(Providers.myNotifProvider);
  final cartCheck = ref.watch(Providers.myNotifProvider).cart;
 final foodInfo =widget.foodInfos ;
    return  Scaffold(
      body: SafeArea(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
  IconButton(onPressed: onTap, icon: const Icon(Icons.arrow_back_ios)),
         
         Center(
           child: Container( width: 350,  height: 350, color: null,
            child: Image.network( foodInfo['image'], 
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            )
            ),
         ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(foodInfo['name'], style: AppWidget.mediumfontBold(),),
           Row(
            children: [countProduct( 
              GestureDetector( onTap: (){ 
              foodInfo['quantity'] == 1? setState(() {
                foodInfo['quantity'];
              }) :
              setState(() {
                foodInfo['quantity']--;
              });
            },
              child: const Icon(Icons.remove, color: Colors.white, size: 25,)),
           foodInfo['quantity'] == 1 ? Colors.grey : Colors.brown),
           const SizedBox( width: 15,),
            Text(foodInfo['quantity'].toString(), style: AppWidget.mediumfontBold(),),
            const SizedBox( width: 15,),
            countProduct(GestureDetector( onTap: (){
              setState(() {
                foodInfo['quantity'] ++;
              });
            },
              child: const Icon(Icons.add, color: Colors.white, size: 25,)),
           Colors.brown )
            ],
          )]
          ),
        ), 
         
 Padding( padding: const EdgeInsets.all(10.0),
  child: Text( foodInfo['description'], 
  style: AppWidget.lightFont(),)),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [Text('Delivery Time', style: AppWidget.mediumfontBold(),
      ),
      const SizedBox( width: 25,),
       Row(
        children: [
         const Icon(Icons.alarm), 
       const SizedBox(width: 5,),
         Text('30 min', style: AppWidget.lightFont2(),)
        ],
           )],
    ),
  ),
   const Spacer(),
   Padding(
     padding: const EdgeInsets.all(20),
     child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text('Total Price', style: AppWidget.mediumfontBold(),),
          Text('\$${foodInfo['price']}'.toString())
          ],
        ),
       addToCart((){

      bool productExists = cartCheck.any((food)=> food['name'] == foodInfo['name']);
    if (productExists) {
      showSnackbar(context, 'This Product is already added to your cart.');  
    }  
    else{
       showSnackbar(context, 'Product has been added to your cart');
      cartProvider.addToCart(
        {
    "image": foodInfo['image'],
    "name": foodInfo['name'],
    "quantity": foodInfo['quantity'],
    'price': foodInfo['price'],
    'category': foodInfo['category']
  },
      );
    }
     
       })],
     ),
   ),
   ],
        ),
      ),
    );
  }

  ElevatedButton addToCart( VoidCallback add) {
    return ElevatedButton.icon(
      onPressed: add, label: const Padding(
        padding:  EdgeInsets.only(right: 10),
        child: Text('Add To Cart', style:  TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black
          )
               ),
      ), iconAlignment: IconAlignment.end,
   style: ElevatedButton.styleFrom( minimumSize: const Size(200, 50), padding: const EdgeInsets.only( right: 5),
   shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
    iconColor: Colors.white, backgroundColor: Colors.brown
   ),
   icon: Icon(MdiIcons.cart),);
  }

  Container countProduct( Widget buttons, Color? color) {
    return Container( decoration:  BoxDecoration(color:  color, 
        borderRadius: BorderRadius.circular(8)),
          child: buttons
        );
  }
}