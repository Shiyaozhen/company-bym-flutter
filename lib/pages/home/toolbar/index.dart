import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    List<String> _svgAssets = [
      'assets/ic_mine.svg',
      'assets/ic_overview.svg',
      'assets/ic_station.svg'
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // 设置为fixed
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset('assets/ic_overview.svg',
                  width: 28,
                  height: 28,
                  // ignore: deprecated_member_use
                  color: selectedIndex == 0
                      ? Color(0xFF55AAFF)
                      : Color(0xFF9cb4c9))
                      ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset('assets/ic_station.svg',
                  width: 28,
                  height: 28,
                  // ignore: deprecated_member_use
                  color: selectedIndex == 1
                      ? Color(0xFF55AAFF)
                      : Color(0xFF9cb4c9))),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset('assets/ic_mine.svg',
                  width: 28,
                  height: 28,
                  // ignore: deprecated_member_use
                  color: selectedIndex == 2
                      ? Color(0xFF55AAFF)
                      : Color(0xFF9cb4c9))),
          label: '',
        )
      ],
    );
  }
}
