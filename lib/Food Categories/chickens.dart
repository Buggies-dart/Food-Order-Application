import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/Product%20Details/details.dart';
import 'package:food_delivery_app/foods.dart';
import 'package:food_delivery_app/utils.dart';

class Chickens extends StatelessWidget {
  const Chickens({super.key});

  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>> chickens = foodProducts.where((food) => food['category'] == 'Chickens').toList();
      return Expanded(
        child: GridView.builder( itemCount: chickens.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  mainAxisSpacing: 20, crossAxisSpacing: 2, ), 
        itemBuilder: (context, index){
         final showFoods = chickens[index];
          return Padding(
            padding: const EdgeInsets.only( left: 8, right: 8),
            child: GestureDetector( onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
            return ProductDetails(foodInfos: showFoods);
            }));
            },
              child: Chip( side: BorderSide.none, elevation: 10, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ), shadowColor: Colors.black,
                label: Column(
                children: [
                  SizedBox( height: 112,
                    child: Center(child: Image.asset(showFoods['image'], fit: BoxFit.fill,))),
                 Text(showFoods['name'], style: AppWidget.mediumfontBold(),),
                 Text(showFoods['tagline'], style: AppWidget.lightFont(),),
                 Text('\$ ${showFoods['price'].toString()}',  style: AppWidget.mediumfontBold(),)],
              )),
            ),
          );
        }),
      );

    
  }
}