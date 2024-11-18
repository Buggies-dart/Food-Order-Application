import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils.dart';

void showSnackbar(
  BuildContext context, String text
){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text, style: 
AppWidget.buttonText(),),
elevation: 10,));
}

void showDialogBox(BuildContext context, VoidCallback delete, VoidCallback noDelete,
String title, String content){
  showDialog(context: context, builder: (context){
return AlertDialog( backgroundColor: Colors.white, elevation: 5,
  title: Text(title, style: AppWidget.mediumfontBold(), maxLines: 2,),
content: Text(content, style: AppWidget.lightFont(),),
actions: [
  TextButton(onPressed: noDelete, child: const Text('No', style: TextStyle(color: Colors.black),)), 
  TextButton(onPressed: delete, child: const Text('Yes', style: TextStyle(color: Colors.red),))
],);
  });
}