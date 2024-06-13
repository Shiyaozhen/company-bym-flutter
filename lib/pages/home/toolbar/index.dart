import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    /*List<String> _svgAssets = [
      'assets/ic_mine.svg',
      'assets/ic_overview.svg',
      'assets/ic_station.svg'
    ];*/

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: SvgPicture.asset('assets/ic_station.svg',
                width: 28,
                height: 28,
                // ignore: deprecated_member_use
                color:
                    selectedIndex == 0 ? Color(0xFF5475F7) : Color(0xFFCAD2E5)),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset('assets/ic_overview.svg',
                width: 28,
                height: 28,
                color: selectedIndex == 1
                    ? Color(0xFF5475F7)
                    : Color(0xFFCAD2E5),)
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SvgPicture.asset('assets/ic_mine.svg',
                width: 28,
                height: 28,
                // ignore: deprecated_member_use
                color:
                    selectedIndex == 2 ? Color(0xFF5475F7) : Color(0xFFCAD2E5)),
          ),
          label: '',
        ),
      ],
    );
  }
}
