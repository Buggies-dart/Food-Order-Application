import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<AddItem> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {

List<String> foodCategories = ['Ice Cream', 'Burger', 'Meals', 'Pizza'];
  String? value;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDetail = TextEditingController();
  final ImagePicker? picker = ImagePicker();
  File? selectedImage;

Future getImage() async{
  var image = await picker?.pickImage(source: ImageSource.gallery);
  if ( image != null) {
    setState(() {
    selectedImage = File(image.path);
  });
  }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
appBar: AppBar( title: Text('Add item', style: AppWidget.largefontBold(),),
centerTitle: true, leading: IconButton( onPressed: (){
  Navigator.pop(context);
}, 
 icon: const Icon(Icons.arrow_back) ),
 backgroundColor: ShowColors.primary(),),
body:  SingleChildScrollView(
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Upload The Item Picture', style: AppWidget.mediumfontBold(),),
    ),
   const SizedBox( height: 20,),
   GestureDetector( onTap: (){
    getImage();
   },
     child: Center(
       child: selectedImage == null? Container(  decoration:  BoxDecoration(color: null, border: const Border.symmetric(
        vertical: BorderSide(width: 2, color: Colors.black), horizontal: BorderSide(width: 2, color: Colors.black)
       ),
        borderRadius: BorderRadius.circular(20)),
       height: 130, width: 125,
        child:  Icon(MdiIcons.camera),
       ) :
       Container(  decoration:  BoxDecoration(color: null, border: const Border.symmetric(
        vertical: BorderSide(width: 2, color: Colors.black), horizontal: BorderSide(width: 2, color: Colors.black)
       ),
        borderRadius: BorderRadius.circular(10)),
       height: 130, width: 125,
        child:  Image.file(selectedImage!, fit: BoxFit.cover,),
       ),
     ),
   ),
  const SizedBox( height: 30,),
    inputFields('Item Name', 1, 'Enter Item Name', controllerName),
    inputFields('Item Price', 1, 'Enter Item Price', controllerPrice),
    inputFields('Item Detail', 6, 'Enter Item Detail', controllerDetail),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Select a Category', style: AppWidget.mediumfontBold(),),
    ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container( 
    width: double.infinity, padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
     color: const Color.fromARGB(255, 224, 220, 220), borderRadius: BorderRadius.circular(15)
    ),
      child: DropdownButtonHideUnderline(  child: DropdownButton<String>( value: value,
        items: List.generate(foodCategories.length, (index){
      return  DropdownMenuItem(  value: foodCategories[index], 
        child: Text(foodCategories[index]));
        }, ), onChanged: ((newValue)=> setState(() {
          value = newValue;
        })
        ) , 
        dropdownColor: Colors.white,
       iconSize: 35, icon: const Icon(Icons.arrow_drop_down, color: Colors.black,), hint: const Text('Please select a category'),)
        ),
    ),
  ),
   Center(child: Padding(
     padding: const EdgeInsets.only(bottom: 50),
     child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(elevation: 5, shadowColor: Colors.black, backgroundColor: ShowColors.primary(),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) ) ),
     child: Text('Add Item', style: AppWidget.buttonText(),) 
     ),
   )
   ) 
   ],
  ),
),
);
  }

  Column inputFields(String item, int maxLines, String hint, TextEditingController controller){
    return Column( 
  children: [
    Align( alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(item, style: AppWidget.mediumfontBold(),),
      )),
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: TextField( maxLines: maxLines, controller: controller,
    decoration: InputDecoration( filled: true, hintText: hint,
      fillColor: const Color.fromARGB(255, 224, 220, 220), 
      focusedBorder: OutlineInputBorder( borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ), border: OutlineInputBorder( borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      )
   ),
   ),
 ) 
 ],
);
  }
}
