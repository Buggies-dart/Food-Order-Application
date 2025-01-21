
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/Product%20Details/details.dart';
import 'package:food_delivery_app/foods.dart';
import 'package:food_delivery_app/utils.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.category});
final String category;
  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>> chickens = foodProducts.where((food) => food['category'] == category).toList();
return Scaffold(
  body: Column(
          children: [
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
        ),
);

    
  }
}