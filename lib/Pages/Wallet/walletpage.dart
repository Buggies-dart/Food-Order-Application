import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/stripe%20payment/keys.dart';
import 'package:food_delivery_app/stripe%20payment/stripe_func.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  TextEditingController amountcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = publishableKey;
  }
  @override
  void dispose() {
    super.dispose();
    amountcontroller;
  }
void paymentfor100Bucks() async{
 await StripeService().makePayment(context, ref, '20');
 }

void paymentfor500Bucks() async{
   await StripeService().makePayment(context, ref, '50');
  }
 
void paymentfor1KBucks() async{
   await StripeService().makePayment(context, ref, '100');
  }
 
  void paymentfor2KBucks() async{
  await StripeService().makePayment(context, ref, '150');

  }
  
  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final wallet = ref.watch(Providers.myNotifProvider).wallet;
    return  Scaffold(
  backgroundColor: theme.scaffoldBackgroundColor, appBar: AppBar( title: Text('Wallet', style: theme.textTheme.displayLarge,),
  centerTitle: true, backgroundColor: theme.scaffoldBackgroundColor, leading: iconButton((){Navigator.pop(context);}),),
   body:  Column( 
    children: [
      Container( decoration: BoxDecoration(
gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()])
      ),
child: ListTile(leading: Image.asset('assets/logos/wallet.png', fit: BoxFit.cover,),
title: const Padding( padding:  EdgeInsets.only(left: 25),
child: Text('Your Wallet', style: TextStyle( fontSize: 18, color: whiteColor
),),
),
subtitle: Padding(
padding: const EdgeInsets.only(left: 25),
child: Text('\$${wallet.toStringAsFixed(2)}', style:  const TextStyle(
 fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor
)),
        ),),
      ),
     Padding(
       padding:  EdgeInsets.only(top: 20, right: MediaQuery.of(context).size.width/1.5),
       child: Text('Add Money', style:theme.textTheme.displayMedium,),
     ),
       Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           moneyChip('20', paymentfor100Bucks), 
           moneyChip('50', paymentfor500Bucks), 
           moneyChip('100', paymentfor1KBucks),
            moneyChip('150', paymentfor2KBucks)
         ],
       ),
      const SizedBox(height: 50,),
      SizedBox(  height: 60,
      width: MediaQuery.of(context).size.width / 1.09,
        child: Container( decoration: BoxDecoration( gradient: LinearGradient(colors: [
ShowColors.primary(), ShowColors.secondary()
        ]),
 borderRadius: BorderRadius.circular(15),     ),
          child: ElevatedButton(onPressed: (){
openEdit();
 }, 
style: ElevatedButton.styleFrom(  backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
),
child: Text('Add Money', style: AppWidget.buttonText(),),),
        ),
      )
      ],
   ), 
   );
  }

  Widget moneyChip(String text, VoidCallback addFunds) {
    return GestureDetector( onTap: addFunds,
      child: Chip(label: Text('\$$text', style: Theme.of(context).textTheme.displayMedium,), backgroundColor: null,
       padding: const EdgeInsets.all(1),),
    );
  }
 Future<void> openEdit() async {
  if (!mounted) return;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
return Padding(
padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom,
left: 20, right: 20, top: 20,),
child: Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
 Text( "Add Money", style:Theme.of(context).textTheme.displayMedium
),
IconButton( icon: const Icon(Icons.close),
onPressed: () => Navigator.pop(context),
),
],
),
const SizedBox(height: 10),
 Text("Amount", style:Theme.of(context).textTheme.displaySmall),
const SizedBox(height: 10),
TextField( controller: amountcontroller, keyboardType: TextInputType.number, decoration: InputDecoration(
border: const OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(40)), borderSide: BorderSide(width: 0.05)),
hintText: 'Enter Amount', hintStyle:Theme.of(context).textTheme.displaySmall
),
),
const SizedBox(height: 20),
Center( child: SizedBox( width: MediaQuery.of(context).size.width /1.9, height: 45,
child: Padding( padding: const EdgeInsets.only(bottom: 8),
child: Container( decoration: BoxDecoration( gradient: LinearGradient(colors: [ShowColors.primary(), ShowColors.secondary()]),
 borderRadius: BorderRadius.circular(10) ),
  child: ElevatedButton( style:  ElevatedButton.styleFrom(
  backgroundColor:  Colors.transparent, shadowColor: Colors.transparent
   ),
  onPressed: () async {
  final String enteredAmount = amountcontroller.text.trim();
  if (enteredAmount.isEmpty) {
  showSnackbar(context, 'Please Enter Your Amount');
  return;
  }
                    
  final double? parsedAmount = double.tryParse(enteredAmount);
  if (parsedAmount == null || parsedAmount <= 0) {
   showSnackbar(context, 'Please Enter a Valid Amount');
   return;
   }
   Navigator.pop(context);
  await StripeService().makePayment(context, ref, enteredAmount);
  amountcontroller.clear();
  },
  child: const Text("Pay", style: TextStyle(color: whiteColor, fontSize: 25),),
  ),
),
),
),
),
],
),
);
},
  );
}
 
}