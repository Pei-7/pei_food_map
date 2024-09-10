import 'package:flutter/material.dart';
import 'common.dart';
import 'cuisine.dart';
import 'package:google_fonts/google_fonts.dart';

import 'list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: (MediaQuery.of(context).size.height >
                MediaQuery.of(context).size.width)
            ? 100
            : 88,
        centerTitle: true,
        title: const Column(children: [
          AppBarImage(),
          SizedBox(height: 4),
          AppBarTitle(),
        ]),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: CuisineCards(),
        ),
      ),
    );
  }
}

class CuisineCards extends StatelessWidget {
  const CuisineCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var i = 0; i < cuisineList.length; i++) CuisineCard(i: i),
          ],
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("🐾 Pei's food map ",
        textAlign: TextAlign.center,
        style: GoogleFonts.gochiHand(
            textStyle: Theme.of(context).textTheme.headlineLarge));
  }
}

class AppBarImage extends StatelessWidget {
  const AppBarImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.getStandardSize(context).width * 0.42,
      child: Image.asset(
        'assets/mktLogo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class CuisineCard extends StatelessWidget {
  const CuisineCard({
    super.key,
    required this.i,
  });

  final int i;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: (screenHeight > screenWidth)
          ? screenWidth * 0.42
          : screenHeight * 0.42,
      child: GestureDetector(
        onTap: () {
          navigateToListPage(context);
        },
        child: CuisineTile(i: i),
      ),
    );
  }

  void navigateToListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPage(
          cuisine: cuisineList[i],
        ),
      ),
    );
  }
}

class CuisineTile extends StatelessWidget {
  const CuisineTile({
    super.key,
    required this.i,
  });

  final int i;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/cuisine/${cuisineList[i].fileName}.jpg'));
  }
}

List<Cuisine> cuisineList = [
  Cuisine.braisedPorkRice,
  Cuisine.juteSoup,
  Cuisine.dryNoodleWithSauce,
  Cuisine.drinks,
  Cuisine.ice,
  Cuisine.vegetarian,
  Cuisine.turnipCake,
  Cuisine.buns,
  Cuisine.taiwaneseMeatball,
  Cuisine.dryRiceNoodle,
  Cuisine.sushi,
  Cuisine.sashimi,
  Cuisine.meatPuff,
  Cuisine.cookedSideDishes,
  Cuisine.wontonSoup,
  Cuisine.stirFry,
];
