
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/Product%20Details/details.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/foods.dart';
import 'package:food_delivery_app/utils.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.category});
final String category;
  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
final sizeHeight = MediaQuery.of(context).size.height;
  List<Map<String, dynamic>> chickens = foodProducts.where((food) => food['category'] == category).toList();
return Scaffold(
  body: SingleChildScrollView( scrollDirection: Axis.vertical,
    child: Stack(
      children: [ SafeArea(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
Row(
  children: [ iconButton((){ Navigator.pop(context); }),
  Padding(
    padding:  EdgeInsets.only(left: sizeHeight/40), 
    child: Text('Find Your Favorite\nDelight!', style: theme.textTheme.displayLarge),
            ),
  ],
),
        SizedBox(height: sizeHeight/50),  
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
                ), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
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
        padding: const EdgeInsets.all(10),
        child: Text('Check Out Our Menus', style: theme.textTheme.displayMedium,),
      ),
                  SizedBox( height: MediaQuery.of(context).size.height,
                    child: GridView.builder( itemCount: chickens.length, scrollDirection: Axis.vertical,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  mainAxisSpacing: 20, crossAxisSpacing: 2), 
                    itemBuilder: (context, index){
                     final showFoods = chickens[index];
                      return Padding(
                        padding: const EdgeInsets.only( left: 8, right: 8),
                        child: GestureDetector( onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProductDetails(foodInfos: showFoods);
                        }));
                        },
                          child: Chip( side: BorderSide.none,  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                            label: Column(
                            children: [
                              SizedBox( height: MediaQuery.of(context).size.height/9,
                                child: Center(child: Image.network(showFoods['image'], fit: BoxFit.fill,))),
                             Text(showFoods['name'], style: theme.textTheme.displayMedium),
                             Text(showFoods['tagline'], style:const TextStyle( fontSize: 18, color: whiteColor2
)),
                             Text('\$ ${showFoods['price'].toString()}',  style: theme.textTheme.displayMedium,)],
                          )),
                        ),
                      );
                    }),
                  ),
                ],
              ),
      ),
    backgroundImage('assets/logos/backgroundimg.png')]),
  ),
);

  }
}

