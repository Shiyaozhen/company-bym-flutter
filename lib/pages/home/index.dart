import 'package:BYM/pages/home/mine/index.dart';
import 'package:BYM/pages/home/overview/index.dart';
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/home/toolbar/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: const [
                PlantListPage(),
                OverViewIndex(),
                Mine(arguments: {},),
              ],
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(
                () {
                  selectedIndex = index;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
