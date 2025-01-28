import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/Cart/foodcart.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/Widgets/food_categories.dart';
import 'package:food_delivery_app/Widgets/mini_widgets.dart';
import 'package:food_delivery_app/Widgets/categories.dart';
import 'package:food_delivery_app/foods.dart';
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
final sizeHeight = MediaQuery.of(context).size.height;
final sizeWidth = MediaQuery.of(context).size.width;
final theme = Theme.of(context);
return Scaffold(
body: 
SingleChildScrollView( scrollDirection: Axis.vertical,
child: Stack( 
  children: [ Column( mainAxisSize: MainAxisSize.min,
  children: [
    SizedBox( height: sizeHeight/35),
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [
   Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  usernameAsyncValue.when( data: (username) {
  return Text( 'Hello ${username ?? 'Guest'} \u{1F44B}',
  style: theme.textTheme.bodySmall,
   );
  },
  error: (error, _) => Text('Error: $error'),
   loading: () => const Text(''),),
  IconButton( onPressed: () {
  Navigator.push( context,
  MaterialPageRoute(
  builder: (context) => const FoodCart(),
  ),
  );
  },
  icon: cart.isEmpty ? Icon(MdiIcons.cart) : Stack(
  children: [ Icon(MdiIcons.cart), 
  Positioned(
  left: 15,
  child: Container( width: 9, height: 9, decoration: BoxDecoration( color: ShowColors.secondary(),
  borderRadius: BorderRadius.circular(10),
   ),
  ),
  ),
  ],
   ),
   ),
  ],
  ),
  Text('Delicious Food', style: theme.textTheme.displayLarge),
  Text( 'Discover and order delicious meals!',
  style: theme.textTheme.displaySmall
  ),
  SizedBox(height: sizeHeight/50),  
  ],
   ),
   ),
    Padding(
padding: const EdgeInsets.symmetric(horizontal: 10),
child: Row(
children: [
Expanded(
child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox( height: sizeHeight/20,
        child: TextField(
        decoration: InputDecoration(label:  Center(child: Text('What do you want to order?', style: TextStyle(color: theme.colorScheme.secondaryContainer, fontSize: 16),)), hintStyle: const TextStyle(color: secondaryColor),
        prefixIcon: Padding( padding: const EdgeInsets.only(left: 20),
        child: Icon(Icons.search,   color:  theme.colorScheme.secondaryContainer, size: 30,),
          ), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
         filled: true, fillColor: theme.colorScheme.onSecondaryContainer),
          ),
      ),
      ),
      ),
      GestureDetector(  onTap: (){
      final results = showSearch(context: context, delegate: FoodSearch(
searchTextStyle: theme.textTheme.displayMedium!
      ));
        },
        child: Container( height: sizeHeight/20, width: sizeHeight/20, decoration:  BoxDecoration( color: theme.colorScheme.onSecondaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10)) ),
        child: Icon(Icons.filter_list, color: theme.colorScheme.secondaryContainer), 
        ),
      )
      ],
      ),
    ),
  SizedBox( height: sizeHeight/50),
    Stack(
      children: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container( width: double.infinity, height: sizeHeight/5,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
        ShowColors.primary(), ShowColors.secondary()
        ])
        ),    
          child: Row(
        children: [
        Image.network("https://res.cloudinary.com/dnkcbhh4n/image/upload/v1737274811/beer_can-removebg-preview_gp2pmj.png"),
        Padding(
        padding:  EdgeInsets.only(top: sizeHeight/30, right: sizeWidth/12),
        child: Column(
          children: [
        Text('Special Deal For \nOctober', style: theme.textTheme.displayLarge,),
        SizedBox( height: sizeHeight/50,),

SizedBox( height: sizeHeight/23,
child: ElevatedButton(onPressed: chickenPage,
 style: ElevatedButton.styleFrom(
backgroundColor: whiteColor, elevation: 15,  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
),
child: Text('Buy Now', style: TextStyle( fontSize: 16, foreground: Paint()..shader =  LinearGradient(
 colors: [ShowColors.primary(), ShowColors.secondary()],
begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          ).createShader( const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),)
          )
          ),
        )],
        ),
        )
        ],
          ),
        ),
      ),
  Positioned.fill( left: sizeWidth/19, right: sizeWidth/19, top: sizeHeight/70, bottom: sizeHeight/70,
    child: backgroundImage('assets/logos/backgroundimg2.png'))
]
  ),
  SizedBox( height: sizeHeight,
    child: const FoodCategories())
   ],
  ),
backgroundImage('assets/logos/backgroundimg.png')
]
),
),
 );
  }
void chickenPage(){
Navigator.push(context, MaterialPageRoute(builder: (context){
return const Categories(category: 'Chickens');
}));
  }
}

class FoodSearch extends SearchDelegate<String>{
final TextStyle searchTextStyle;
FoodSearch({required this.searchTextStyle});
final categories = [
  'Pizzas', 'Chickens', 'Meals', 'Ice Creams'
];
final categoriesResult = [
  'Pizzas', 'Chickens', 'Meals', 'Ice Creams'
];
 @override
  List<Widget> buildActions(BuildContext context){
    return [
    IconButton(onPressed: (){
    query.isEmpty ? close(context, '') :
    query = '';
    }, icon: const Icon(Icons.clear))
    ];
  }
  
  @override
  TextStyle? get searchFieldStyle => searchTextStyle;

  @override
  String get searchFieldLabel => 'Search for food items...';
  
  @override
  Widget buildLeading(BuildContext context)=> IconButton(onPressed: (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
  return const Navigation();
}));
  }, icon: const Icon(Icons.arrow_back_ios));
 
  @override
  Widget buildResults(BuildContext context) {

 return Column(
      children: [
        Categories(category: query),
      ],
    );
  }
 
  @override
  Widget buildSuggestions(BuildContext context) {
  final foodSuggestions = foodProducts.map((foodSuggestion)=>foodSuggestion['name']).toList();
  final  realFoodCategories = categories;
  final suggestions = query.isEmpty ? categoriesResult : realFoodCategories.where((realFoodCategory) {
  final categoryLowerCase = realFoodCategory.toLowerCase();
  final queryLowerCase = query.toLowerCase();
 return categoryLowerCase.startsWith(queryLowerCase);
  }).toList();
  return buildSuggestionOutcome(suggestions, foodSuggestions, context);
  }
Widget buildSuggestionOutcome(List suggestions, List foodSuggestions, BuildContext context){
final sizeHeight = MediaQuery.of(context).size.height;
 return Column( mainAxisSize: MainAxisSize.min,
   children: [ 
    SizedBox( height: sizeHeight/40),
  Center(child: Text('Categories', style: Theme.of(context).textTheme.displayMedium)),
     SizedBox(  height: 150, width: MediaQuery.of(context).size.width/1,
       child: GridView.builder( gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 2,
       childAspectRatio: 1.25 / 2),
 scrollDirection: Axis.horizontal,
        itemCount: suggestions.length, itemBuilder: (context, index){
        final suggestion = suggestions[index];
       return Padding(
        padding: const EdgeInsets.all(8.0),
       child: SizedBox( width: 400,
         child: GestureDetector( onTap: (){
  query = suggestion;
  showResults(context);   
         },
        
child: Container( decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
color: Theme.of(context).colorScheme.primaryContainer,
),
child: Center(child: Text( 
suggestion.toString(), style: Theme.of(context).textTheme.displaySmall)),
),
),
),
);
}),
     ),
SizedBox( height: sizeHeight/50),
 Center(child: Text('Menus', style: Theme.of(context).textTheme.displayMedium,)),
 SizedBox( height: sizeHeight/50),
  SizedBox(  height: sizeHeight/3.2, width: MediaQuery.of(context).size.width/1,
       child: ListView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
 scrollDirection: Axis.vertical,
        itemCount: 6, itemBuilder: (context, index){
        final suggestion = foodSuggestions[index].toString();
       return SizedBox( width: double.infinity, 
         child: Container( decoration: BoxDecoration(
         color: Theme.of(context).colorScheme.primaryContainer,
         ),
         child: Padding(
           padding: const EdgeInsets.all(15),
           child: Text(suggestion, style: Theme.of(context).textTheme.displaySmall),
         ),
                    
         ),
       );
       }),
     ),
   ],
 );
}

}