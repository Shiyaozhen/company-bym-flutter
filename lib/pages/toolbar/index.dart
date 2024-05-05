import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTabSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // 设置为fixed
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'WifiList',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi),
          label: 'Connect',
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.bluetooth),
          label: 'Connect',
        )
      ],
    );
  }
}
