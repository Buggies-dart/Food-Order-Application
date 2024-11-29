import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Food%20Categories/chickens.dart';
import 'package:food_delivery_app/Food%20Categories/grid.dart';
import 'package:food_delivery_app/Food%20Categories/ice_cream.dart';
import 'package:food_delivery_app/Food%20Categories/pizzas.dart';
import 'package:food_delivery_app/Pages/Cart/foodcart.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {

  @override
  Widget build(BuildContext context) {
    final usernameAsyncValue = ref.watch(Providers.userProvider);
    final cart = ref.watch(Providers.myNotifProvider).cart;

    return Scaffold(
      body: 
         SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        usernameAsyncValue.when(
                          data: (username) {
                            return Text(
                              'Hello ${username ?? 'Guest'} \u{1F44B}',
                              style: AppWidget.mediumfontBold(),
                            );
                          },
                          error: (error, _) => Text('Error: $error'),
                          loading: () => const Text(''),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FoodCart(),
                              ),
                            );
                          },
                          icon: cart.isEmpty
                              ? Icon(MdiIcons.cart)
                              : Stack(
                                  children: [
                                    Icon(MdiIcons.cart),
                                    Positioned(
                                      left: 15,
                                      child: Container(
                                        width: 9,
                                        height: 9,
                                        decoration: BoxDecoration(
                                          color: ShowColors.secondary(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Delicious Food', style: AppWidget.largefontBold()),
                    Text(
                      'Discover and order delicious meals!',
                      style: AppWidget.lightFont(),
                    ),
                    const SizedBox(height: 25),
                  const ChipSelect()
                  ],
                ),
              ),
              
            ],
          ),
        ),
    );
  }
}

int selected = 0;
class ChipSelect extends StatefulWidget {
  const ChipSelect({super.key});
  @override
  ChipSelectState createState() => ChipSelectState();
}
class ChipSelectState extends State<ChipSelect> {
  

  @override
  Widget build(BuildContext context) {
    final chipIcons = [
      MdiIcons.iceCream,
      MdiIcons.pizza,
      MdiIcons.rice,
      MdiIcons.foodDrumstick,
    ];

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 73,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate( 
                chipIcons.length,
                (index) {
                  return Padding(
                    padding:  EdgeInsets.only(left: 5, right: MediaQuery.of(context).size.width/12,),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6.5, height: 70,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index; // Update the selected index when chip is tapped
                          });
                        },
                        child: Chip(
                          elevation: 5,
                          side: BorderSide.none,
                          padding: const EdgeInsets.only(right: 5, top: 7, bottom: 7),
                          backgroundColor: selected == index
                              ? ShowColors.secondary()
                              : Colors.white,
                          shadowColor: Colors.black,
                          label: Center(
                            child: Icon(
                              chipIcons[index],
                              size: 50,
                              color: selected == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox( height: 20),
         IndexedStack(
           index: selected,
           children: const [
            IceCream(),
              Pizza(),
              Meals(),
              Chickens(),
           ],
         ),
      ],
    );
  }
}


