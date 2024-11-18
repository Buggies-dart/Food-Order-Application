import 'package:flutter/material.dart';
import 'package:food_delivery_app/admin/add_item.dart';
import 'package:food_delivery_app/utils.dart';

class Adminhome extends StatelessWidget {
  const Adminhome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( appBar: AppBar(title:  Text('Halle\'s Dinning Admin',
    style: AppWidget.largefontBold(),), centerTitle: true,
  ),
      body:  Column(
        children: [
         const SizedBox( height: 40),
          SizedBox( height: 130, width: MediaQuery.of(context).size.width /0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
              return const AddItem();
              })),
                child: Card( elevation: 20, shadowColor: Colors.grey, color: ShowColors.secondary(),
                  child: Row( 
                    children: [ Image.asset('assets/images/test.png', width: 120, fit: BoxFit.fill,),
                    const SizedBox( width: 40),
                   Text('Add Food Items', style: AppWidget.mediumfontBold(),) ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}