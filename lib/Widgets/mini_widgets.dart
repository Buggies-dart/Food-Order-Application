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