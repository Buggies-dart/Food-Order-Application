import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/Cart/foodcart.dart';
import 'package:food_delivery_app/Widgets/food_categories.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {

  @override
  Widget build(BuildContext context) {
    final usernameAsyncValue = ref.watch(Providers.userProvider);
    final cart = ref.watch(Providers.myNotifProvider).cart;
final sizeHeight = MediaQuery.of(context).size.height;
final theme = Theme.of(context);
    return Scaffold(
      body: 
SingleChildScrollView( scrollDirection: Axis.vertical,
child: Column( mainAxisSize: MainAxisSize.min,
children: [
  SizedBox( height: sizeHeight/35),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 10),
child: Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
 Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
usernameAsyncValue.when( data: (username) {
return Text( 'Hello ${username ?? 'Guest'} \u{1F44B}',
style: theme.textTheme.bodySmall,
 );
},
error: (error, _) => Text('Error: $error'),
 loading: () => const Text(''),),
IconButton( onPressed: () {
Navigator.push( context,
MaterialPageRoute(
builder: (context) => const FoodCart(),
),
);
},
icon: cart.isEmpty ? Icon(MdiIcons.cart) : Stack(
children: [ Icon(MdiIcons.cart), 
Positioned(
left: 15,
child: Container( width: 9, height: 9, decoration: BoxDecoration( color: ShowColors.secondary(),
borderRadius: BorderRadius.circular(10),
 ),
),
),
],
 ),
 ),
],
),
Text('Delicious Food', style: theme.textTheme.displayLarge),
Text( 'Discover and order delicious meals!',
style: theme.textTheme.displaySmall
),
SizedBox(height: sizeHeight/50),  
],
 ),
 ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
    children: [
    Expanded(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox( height: 60,
      child: TextField(
      decoration: InputDecoration(label:  Center(child: Text('What do you want to order?', style: TextStyle(color: theme.colorScheme.secondaryContainer, fontSize: 16),)), hintStyle: const TextStyle(color: secondaryColor),
      prefixIcon: Padding( padding: const EdgeInsets.only(left: 20),
      child: Icon(Icons.search, color:  theme.colorScheme.secondaryContainer, size: 40,),
        ), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
       filled: true, fillColor: theme.colorScheme.onSecondaryContainer),
        ),
    ),
    ),
    ),
    Container( height: sizeHeight/20, width: sizeHeight/20, decoration:  BoxDecoration( color: theme.colorScheme.onSecondaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10)) ),
    child: Icon(Icons.filter_list, color: theme.colorScheme.secondaryContainer), 
    )
    ],
    ),
  ),
SizedBox( height: sizeHeight/50),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container( width: double.infinity, height: sizeHeight/5,
    decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(colors: [
    ShowColors.primary(), ShowColors.secondary()
    ])
    ),    
      child: Row(
    children: [
    Image.network("https://res.cloudinary.com/dnkcbhh4n/image/upload/v1737274811/beer_can-removebg-preview_gp2pmj.png"),
    Padding(
    padding: const EdgeInsets.only(top: 30, right: 20),
    child: Column(
      children: [
    Text('Special Deal For \nOctober', style: theme.textTheme.displayLarge,),
    SizedBox( height: sizeHeight/50,),
    ElevatedButton(onPressed: (){},
    style: ElevatedButton.styleFrom(
    backgroundColor: whiteColor, elevation: 15,  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
     child: Text('Buy Now', style: TextStyle(
    fontSize: 16,
              foreground: Paint()
                ..shader =  LinearGradient(
                  colors: [ShowColors.primary(), ShowColors.secondary()],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),)
    )
    )],
    ),
    )
    ],
      ),
    ),
  ),
SizedBox( height: sizeHeight,
  child: const FoodCategories())
 ],
),
),
 );
  }
  
}

// int selected = 0;
// class ChipSelect extends StatefulWidget {
//   const ChipSelect({super.key});
//   @override
//   ChipSelectState createState() => ChipSelectState();
// }
// class ChipSelectState extends State<ChipSelect> {
  

//   @override
//   Widget build(BuildContext context) {
//     final chipIcons = [
//       MdiIcons.iceCream,
//       MdiIcons.pizza,
//       MdiIcons.rice,
//       MdiIcons.foodDrumstick,
//     ];

//     return Column(
//       children: [
//         Container( color: Colors.blue,
//           width: double.infinity,
//           height: 90,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate( 
//                 chipIcons.length,
//                 (index) {
//                   return Padding(
//                     padding:  EdgeInsets.only(left: 5, right: MediaQuery.of(context).size.width/12,),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width / 6.5, height: 70,
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selected = index; 
//                           });
//                         },
//                         child: Chip(
//                           elevation: 5,
//                           side: BorderSide.none,
//                           padding: const EdgeInsets.only(right: 5, top: 7, bottom: 7),
//                           backgroundColor: selected == index
//                               ? ShowColors.secondary()
//                               : Colors.white,
//                           shadowColor: Colors.black,
//                           label: Center(
//                             child: Icon(
//                               chipIcons[index],
//                               size: 50,
//                               color: selected == index ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
       
//          IndexedStack(
//            index: selected,
//            children: const [
//             IceCream(),
//               Pizza(),
//               Meals(),
//               Chickens(),
//            ],
//          ),
//       ],
//     );
//   }
// }


