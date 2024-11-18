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
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final usernameAsyncValue = ref.watch(Providers.userProvider);
    final cart = ref.watch(Providers.myNotifProvider).cart;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
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
                              'Hello ${username ?? 'Guest'}',
                              style: AppWidget.mediumfontBold(),
                            );
                          },
                          error: (error, _) => Text('Error: $error'),
                          loading: () => const Text(''),
                        ),
                        IconButton(
                          onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return const FoodCart();
    }));
                          },
              icon: cart.isEmpty? Icon(MdiIcons.cart) :
                 Stack(children: [ Icon(MdiIcons.cart),
            Positioned( left: 15,
              child: Container( width: 9, height: 9,
              decoration: BoxDecoration(color: ShowColors.secondary(),
              borderRadius: BorderRadius.circular(10) ),),
            ) ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Delicious Food', style: AppWidget.largefontBold()),
                    Text('Discover and order delicious meals!', style: AppWidget.lightFont()),
                    const SizedBox(height: 25),
                    chipSelect(),
                  ],
                ),
              ),
            ),

            SliverFillRemaining(
              child: IndexedStack(
                index: selected,
                children: const [
                  IceCream(),
                  Pizza(),
                  Meals(),
                  Chickens(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chipSelect() {
    final chipIcons = [
      MdiIcons.iceCream,
      MdiIcons.pizza,
      MdiIcons.rice,
      MdiIcons.foodDrumstick,
    ];

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        itemCount: chipIcons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 48),
            child: SizedBox(
              width: 65,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: Chip(
                  elevation: 5,
                  side: BorderSide.none,
                  padding: const EdgeInsets.only(right: 5, top: 7, bottom: 7),
                  backgroundColor: selected == index ? ShowColors.secondary() : Colors.white,
                  shadowColor: Colors.black,
                  label: Icon(
                    chipIcons[index],
                    size: 50,
                    color: selected == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
