import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils.dart';

void showSnackbar(
  BuildContext context, String text
){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.primaryContainer, content: Text(text, style: 
Theme.of(context).textTheme.displayMedium),
elevation: 10,));
}

void showDialogBox(BuildContext context, VoidCallback delete, VoidCallback noDelete,
String title, String content){
  showDialog(context: context, builder: (context){
return AlertDialog( backgroundColor: Theme.of(context).colorScheme.primaryContainer, elevation: 5,
  title: Row(
    children: [
      Text(title, style: Theme.of(context).textTheme.displayMedium, maxLines: 2,),
    ],
  ),
content: Text(content, style: Theme.of(context).textTheme.displaySmall,),
actions: [
  TextButton(onPressed: noDelete, child: const Text('No', style: TextStyle(color: secondaryColor, fontSize: 16),)), 
  TextButton(onPressed: delete, child: Text('Yes', style: TextStyle( fontSize: 16,
  foreground: Paint()..shader = LinearGradient( colors: [ShowColors.primary(), ShowColors.secondary()],
      begin: Alignment.topLeft, end: Alignment.bottomRight,).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
  ),
  ))
],);
  });
}

void showChangeAddressModal(BuildContext context, VoidCallback ontap, TextEditingController addressController) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Center(
              child:  Text(
                'Change Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Enter your new address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ontap,
              style: ElevatedButton.styleFrom(
                backgroundColor: ShowColors.primary(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Change Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showUpdateAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'Address Update',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Row(
          children:  [
            Expanded(
              child: Text(
                'Your address will be updated shortly 😊',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
