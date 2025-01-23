import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils.dart';

Widget backgroundImage(String asset) {
    return IgnorePointer( ignoring: true,
      child: Container(
      color: null, child: Image.asset(asset, fit: BoxFit.fill),
      ),
    );
  }

IconButton iconButton(VoidCallback tap) => IconButton(onPressed: tap,  icon: const Icon(Icons.arrow_back_ios), color: secondaryContainer);

Padding appBar(double sizeHeight, BuildContext context, double sizeWidth, ThemeData theme, String text, VoidCallback route) {
    return Padding(
      padding: EdgeInsets.only(top: sizeHeight/30),
      child: Row(
      children: [
       IconButton(onPressed: route, icon: const Icon(Icons.arrow_back_ios, color: secondaryContainer,),),
      SizedBox(width: sizeWidth/5,),
       Text(text, style: theme.textTheme.displayLarge,),
      ],
        ),
    );
  }


 Widget navIconGradient(Widget nav){
    return ShaderMask( shaderCallback: (Rect bounds) {
            return  LinearGradient(
              colors:  [ShowColors.primary(), ShowColors.secondary()],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ).createShader(bounds);
          },
          child: nav);
  }

void showOrderConfirmationDialog(BuildContext context) {
showDialog( context: context, builder: (BuildContext context) {
return AlertDialog( shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20),
),
content:  Column( mainAxisSize: MainAxisSize.min,
children: [ Image.asset('assets/logos/success.png', width: 100, height: 100),
const SizedBox(height: 16),
  Text( 'Hiyya!',
style:  TextStyle( fontSize: 25, color: ShowColors.primary(),
fontWeight: FontWeight.bold,), textAlign: TextAlign.center,
),
const SizedBox(height: 8),
 Text('Your order is on the way to your delivery address.', style:
Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center,),
const SizedBox(height: 8),
  Text( 'You should get your orders within 45 minutes.',
style:  Theme.of(context).textTheme.displaySmall,  textAlign: TextAlign.center,
),
 ],
),
actions: [ TextButton( onPressed: () { Navigator.of(context).pop();
},
child: const Text('Close'),
),
],
);
},
);
}
