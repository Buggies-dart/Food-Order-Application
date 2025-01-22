import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';


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
  final sizeHeight = MediaQuery.of(context).size.height;
  final sizeWidth = MediaQuery.of(context).size.width;
  final theme = Theme.of(context);
  final cartProvider = ref.read(Providers.myNotifProvider);
  final cartCheck = ref.watch(Providers.myNotifProvider).cart;
 final foodInfo =widget.foodInfos ;
    return  Scaffold( backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [ SafeArea(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
iconButton(onTap),
        Center(
        child: Container( width: sizeWidth/1.35,  height: sizeHeight/2.95, color: null, child: Image.network( foodInfo['image'], 
        width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
        )
        ),
        ),
        
        Expanded(
          child: Container( decoration: BoxDecoration(
         color: theme.colorScheme.primaryContainer, borderRadius: const  BorderRadius.only( topLeft: Radius.circular(60), topRight: Radius.circular(60))
          ),
            child: Column(
        children: [
           Padding( padding: const EdgeInsets.all(8.0), child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(foodInfo['name'], style: theme.textTheme.displayLarge,),
          Padding(
            padding:  EdgeInsets.all(sizeWidth/15),
            child: Row( children: [countProduct( GestureDetector( onTap: (){ foodInfo['quantity'] == 1? setState(() {
            foodInfo['quantity'];}) : setState(() {
            foodInfo['quantity']--;
            });
            },
            child: const Icon(Icons.remove, color: Colors.white, size: 25,)),
            foodInfo['quantity'] == 1 ? const LinearGradient(colors: [ Colors.grey, Colors.grey]) : LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()])), const SizedBox( width: 15,),
            Text(foodInfo['quantity'].toString(), style: theme.textTheme.displayMedium), 
            const SizedBox( width: 15),
            countProduct(
            GestureDetector( onTap: (){
            setState(() {
            foodInfo['quantity'] ++; });
            },
            child: const Icon(Icons.add, color: Colors.white, size: 25,)),
            LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]) )
            ],
            ),
          )]
          ),
          ),
           Padding( padding: EdgeInsets.all(sizeHeight/60),
            child: Text( foodInfo['description'], 
            style: theme.textTheme.displaySmall,)),
            Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Text('Delivery Time', style: theme.textTheme.displayMedium,
          ),
          const SizedBox( width: 25,),
          Row(
          children: [ const Icon(Icons.alarm), 
          const SizedBox(width: 5,),
          Text('30 min', style: theme.textTheme.bodySmall)
          ],
          )],
        ),
            ),
             const Spacer(),
          Padding( padding: const EdgeInsets.all(20), child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column( children: [ Text('Total Price', style:theme.textTheme.displayMedium,), Text('\$${foodInfo['price']}'.toString(), style: 
          theme.textTheme.displaySmall
          )
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
             ),  ],
            ),
          ),
        ), 
           ],
          ),
        ),
  ]),
    );
  }
  Widget addToCart( VoidCallback add) {
    return GestureDetector(  onTap: add,
child: Container( width: MediaQuery.of(context).size.width/2.5, height: MediaQuery.of(context).size.height/18,
decoration: BoxDecoration( gradient: LinearGradient(colors: [
ShowColors.primary(), ShowColors.secondary(),
]), borderRadius: const BorderRadius.all(Radius.circular(10))
),
child: const Padding( padding:  EdgeInsets.only(right: 10), child: Center(
  child: Text('Add To Cart', style:  TextStyle(
  fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor
  )
  ),
),
), 
),
    );
  }

  Container countProduct( Widget buttons, Gradient gradient) {
    return Container( decoration:  BoxDecoration( gradient: gradient,
        borderRadius: BorderRadius.circular(8)),
          child: buttons
        );
  }
  
}