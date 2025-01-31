import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/state_management.dart';
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

void showChangeAddressModal(BuildContext context, VoidCallback ontap, TextEditingController addressController, WidgetRef ref) {
 final addressProvider = ref.watch(Providers.myNotifProvider);
showModalBottomSheet(
context: context, shape: const RoundedRectangleBorder(
borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
),
  isScrollControlled: true,
builder: (context) {
return StatefulBuilder( builder: (context, setState){
return Padding(
padding: const EdgeInsets.all(16.0),
child: Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Center(
child:  Text( 'Change Address', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,
),
),
),
const SizedBox(height: 20),
TextField( style: Theme.of(context).textTheme.displaySmall, controller: addressController,
onChanged: (value) => addressProvider.getUserAddress(value, context),
decoration: InputDecoration( focusColor: Theme.of(context).colorScheme.primaryContainer,
labelText: 'Enter your new address', focusedBorder: OutlineInputBorder( borderSide:  const BorderSide(width: 0.3),
borderRadius: BorderRadius.circular(20),
),
enabledBorder: OutlineInputBorder( borderSide:  const BorderSide(width: 0.3), borderRadius: BorderRadius.circular(20),
),),
),
const SizedBox(height: 20),
addressProvider.showSuggestions?
Center(
child: Material( elevation: 5, shadowColor: blackColor,
child: Container(  width: MediaQuery.of(context).size.width/1.3, color: Theme.of(context).colorScheme.primaryContainer, 
child: 
SizedBox( height:  MediaQuery.of(context).size.height/3,
child: ListView.builder( padding: const EdgeInsets.only(top: 0),
itemCount: addressProvider.suggestions.length, itemBuilder: (context, index){
return  ListTile( onTap: (){
  // Get the selected address
  final selectedAddress = addressProvider.suggestions[index];

  // Update the text field
  addressController.text = selectedAddress;

  // Update provider state properly
  ref.read(Providers.myNotifProvider).updateSelectedAddress(selectedAddress);
     
},
title: Text(addressProvider.suggestions[index], style: Theme.of(context).textTheme.displaySmall),
);
})
)
),
),
) : const Text(''),
Container(  padding: const EdgeInsets.symmetric(vertical: 15), decoration: BoxDecoration( gradient: LinearGradient(colors: [ShowColors.primary(), 
ShowColors.secondary()]), borderRadius: BorderRadius.circular(20)),
child: ElevatedButton(  onPressed: ontap, style: ElevatedButton.styleFrom( backgroundColor: ShowColors.primary(),
    
),
child:  Center(
child: Text(
'Change Address',
style: Theme.of(context).textTheme.displayMedium
),
 ),
),
) 
    ],
    ),
    );
});

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
