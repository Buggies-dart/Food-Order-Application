import 'package:flutter/material.dart';
import 'package:food_delivery_app/user%20onboarding/login.dart';
import 'package:food_delivery_app/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> onboarding = [
    {
      'image': 'assets/logos/test.png',
      'title': 'Select from Our \n Best menu',
      'description': 'We have varieties of dishes to satisfy your cravings'
    },
    {
      'image': 'assets/logos/testt.png',
      'title': 'Select from Our \n Best menu',
      'description': 'We have varieties of dishes to satisfy your cravings'
    },
    {
      'image': 'assets/logos/test.png',
      'title': 'Select from Our \n Best menu',
      'description': 'We have varieties of dishes to satisfy your cravings'
    }
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
    return Scaffold(
 body: PageView.builder( itemCount: onboarding.length, controller: pageController,
physics: const NeverScrollableScrollPhysics(), onPageChanged: (int index) {
setState(() {
currentPage = index;
});
},
itemBuilder: (context, index) { final indices = onboarding[index];
 return SingleChildScrollView( // Make content scrollable to avoid overflow
child: Column(
 children: [ Container(  color: null, width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height / 1.6,
child: Padding( padding: const EdgeInsets.only(top: 30),
child: Image.asset( indices['image'], fit: BoxFit.contain,
),
),
 ),
Text( indices['title'],style: theme.textTheme.displayLarge,
textAlign: TextAlign.center,
),
const SizedBox(height: 20),
Text( indices['description'], style: theme.textTheme.displaySmall, textAlign: TextAlign.center,),
const SizedBox(height: 30),
 SmoothPageIndicator(
controller: pageController, count: onboarding.length,
 effect: ExpandingDotsEffect( dotHeight: 8, dotWidth: 8, activeDotColor: ShowColors.secondary(),
dotColor: Colors.grey,
),
),
const SizedBox(height: 20),
nextButton(context),
],
),
);
 },
),
    );
  }

  Widget nextButton(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width / 1.15,

      child: GestureDetector( onTap:  () {
if (currentPage < onboarding.length - 1) { setState(() { currentPage++; });
pageController.animateToPage(
currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeInCirc,
);
} else {
Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => const LoginUI()),
);
}
},
child: Container( decoration: BoxDecoration( gradient: LinearGradient(colors: [
ShowColors.primary(), ShowColors.secondary() 
]
),
 borderRadius: BorderRadius.circular(20)    ),
 child: Center(
   child: Text(
   currentPage == onboarding.length - 1 ? 'Done' : 'Next',
   style: const TextStyle(
   fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.white,
   ),
   ),
 ),
),
),
);
  }

  
}
