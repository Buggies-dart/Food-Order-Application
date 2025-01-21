import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Food%20Categories/categories.dart';
import 'package:food_delivery_app/Pages/Product%20Details/details.dart';
import 'package:food_delivery_app/foods.dart';
import 'package:food_delivery_app/utils.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({super.key});

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
final ScrollController  controller = ScrollController();
int currentIndex = 0;
 @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final index = (controller.offset / MediaQuery.of(context).size.width).round();
      if (index != currentIndex) {
        setState(() {
        currentIndex = index;
        });
      }
    });
  }
@override
  void dispose() {
  controller.dispose(); 
super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 final sizeHeight = MediaQuery.of(context).size.height;
  final sizeWidth = MediaQuery.of(context).size.width;
 final random = Random();
  final randomFoods =  List.generate(5, (_) => foodProducts[random.nextInt(foodProducts.length)]);
return  Scaffold( 
body: Column( mainAxisSize: MainAxisSize.min,
children: [
Padding(
  padding:  EdgeInsets.all(sizeWidth/30),
  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
   Text('Food Categories', style: Theme.of(context).textTheme.displayMedium,), 
  TextButton(onPressed: (){}, child: const Text('View More', style: TextStyle(color: secondaryColor),))
  ],
  ),
),
SizedBox( height: sizeHeight/4, width: double.infinity,
  child: ListView.builder( scrollDirection: Axis.horizontal, controller: controller,
itemCount: 4, itemBuilder: (context, index){
 return Padding(
    padding: const EdgeInsets.all(12),
    child: GestureDetector( onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context){
return Categories(category: foodCategories[index]['name'].toString());
}));
    },
      child: Container( width: sizeHeight/6,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(10)),
      child: Column( 
      children: [
        Container( color: null, height: sizeHeight/6,
          child: Image.asset(foodCategories[index]['image'].toString(), fit: BoxFit.contain,)),
        const SizedBox( height: 5,),
        Text(foodCategories[index]['name'].toString(), style: Theme.of(context).textTheme.displayLarge,)
      ],
      ),
      ),
    ),
  );
  }),
),
 Row(
 mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (index) {
return Container( margin: const EdgeInsets.symmetric(horizontal: 4.0),
width: 10, height: 10, decoration: BoxDecoration( color: currentIndex == index ? ShowColors.primary() : Colors.grey,
shape: BoxShape.circle,
),
);
 }),
),
 Flexible( fit: FlexFit.loose,
   child: Column(  mainAxisSize: MainAxisSize.min,
     children: [
   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: [
   Text('Popular Menus', style: Theme.of(context).textTheme.displayMedium),
   TextButton(onPressed: (){}, child: const Text('View More', style: TextStyle(color: secondaryColor),))
   ],
   ),
 Expanded(
            child: ListView.builder(itemCount: randomFoods.length, scrollDirection: Axis.vertical, itemBuilder: (context, index){
             final randomFood =randomFoods[index];
             return SizedBox( height: sizeHeight/10,
               child: Padding(
                 padding:  EdgeInsets.only(bottom: sizeHeight/75),
                 child: ListTile( onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
return ProductDetails(foodInfos: randomFood);
        }));
                 }, tileColor: Theme.of(context).colorScheme.primaryContainer, shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20)
                 ),
                 leading: Container( width: sizeWidth/6.5, height: sizeWidth/1,
                   decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(10)
                 ),
                    child: Image.network(randomFood['image'], fit: BoxFit.cover)), title: Text(randomFood['name'], style: Theme.of(context).textTheme.displayMedium,), subtitle: Text(randomFood['category'], style: const TextStyle(
color: whiteColor2
                    ),),
              trailing: Text('\$${randomFood['price']}', style: const TextStyle(
                 fontSize: 28, color: tertiaryContainer, fontWeight: FontWeight.bold
              ),),   ),
               ),
             );
            }),
          ),
     ],
   ),
 )
],
      ),
    );
  }
}
 final List<Map<String, String>> foodCategories = [
    {
  'name' : 'Pizzas',
  'image': 'assets/logos/2.png'
  },
  {
  'name' : 'Meals',
  'image': 'assets/logos/3.png'
  },
    {
  'name' : 'Chickens',
  'image': 'assets/logos/4.png'
  },
    {
  'name' : 'Ice Creams',
  'image': 'assets/logos/1.png'
  }
  ];
