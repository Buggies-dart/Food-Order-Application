import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/Product%20Details/details.dart';
import 'package:food_delivery_app/foods.dart';
import 'package:food_delivery_app/utils.dart';

class Meals extends StatelessWidget {
  const Meals({super.key});

  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>> meals = foodProducts.where((food) => food['category'] == 'Meals').toList();
      return Column(
        children: [
          SizedBox( height: MediaQuery.of(context).size.height/1.59,
            child: GridView.builder( itemCount: meals.length, scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,  mainAxisSpacing: 20, crossAxisSpacing: 2), 
            itemBuilder: (context, index){
             final showFoods = meals[index];
              return Padding(
                padding: const EdgeInsets.only( left: 8, right: 8),
                child: GestureDetector(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProductDetails(foodInfos: showFoods);
                   }));
                },
                  child: Chip( side: BorderSide.none, elevation: 10, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ), shadowColor: Colors.black,
                    label: Column(
                    children: [
                      SizedBox( height: MediaQuery.of(context).size.height/9,
                        child: Center(child: Image.network(showFoods['image'], fit: BoxFit.fill,))),
                     Text(showFoods['name'], style: AppWidget.mediumfontBold(),),
                     Text(showFoods['tagline'], style: AppWidget.lightFont(),),
                     Text('\$ ${showFoods['price'].toString()}',  style: AppWidget.mediumfontBold(),)],
                  )),
                ),
              );
            }),
          ),
        ],
      );

    
  }
}