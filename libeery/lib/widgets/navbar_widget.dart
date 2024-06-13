import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late List<Color> iconColors;

  @override
  void initState() {
    super.initState();
    iconColors = List<Color>.generate(3, (index) => index == widget.selectedIndex ? const Color(0xff333333) : const Color(0xffB2B2B2));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: AppColors.gray,
      selectedItemColor: AppColors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              setState(() {
                iconColors[0] = AppColors.black;
                iconColors[1] = AppColors.gray;
                iconColors[2] = AppColors.gray;
              });
              widget.onItemTapped(0);
            },
            child: Image.asset(
              'assets/icons/Home.png',
              width: 25,
              height: 25,
              color: iconColors[0],
              fit: BoxFit.fill,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              setState(() {
                iconColors[1] = AppColors.black;
                iconColors[0] = AppColors.gray;
                iconColors[2] = AppColors.gray;
              });
              widget.onItemTapped(1);
            },
            child: Image.asset(
              'assets/icons/Books.png',
              width: 35,
              height: 25,
              color: iconColors[1],
            ),
          ),
          label: 'Books',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              setState(() {
                iconColors[2] = AppColors.black;
                iconColors[0] = AppColors.gray;
                iconColors[1] = AppColors.gray;
              });
              widget.onItemTapped(2);
            },
            child: Image.asset(
              'assets/icons/Profile.png',
              width: 25,
              height: 25,
              color: iconColors[2],
            ),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
    );
  }
}