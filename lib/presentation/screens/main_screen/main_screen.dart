import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/constants.dart';
import '../bottom_bar_pages/calendar_page.dart';
import '../bottom_bar_pages/home_page/home_page.dart';
import '../bottom_bar_pages/messages_page.dart';
import '../bottom_bar_pages/profile_page.dart';
import 'widgets/menu_icon_button.dart';
import 'widgets/profile_name_box.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List _pages = [
    HomePage(),
    CalendarPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isSelected(int index) {
    return _selectedIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ProfileNameBox(),
      ),
      body: Container(
        color: Colors.white,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        height: 100 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(200, 30),
            topRight: Radius.elliptical(200, 30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(-6, 0),
              color: Color(0xffAFB8C6).withValues(alpha: 0.12),
              spreadRadius: 0,
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuIconButton(onTap: () => _onItemTapped(0), assetPath: 'assets/icons/home.svg', iconText: 'Home', isSelected: _isSelected(0)),
            MenuIconButton(onTap: () => _onItemTapped(1), assetPath: 'assets/icons/calendar.svg', iconText: 'Calendar', isSelected: _isSelected(1)),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/search'),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 8),
                      color: Color(0xff0d6efd).withValues(alpha: 0.17),
                      spreadRadius: 0,
                      blurRadius: 19,
                    ),
                  ],
                ),
                child: Center(child: SvgPicture.asset('assets/icons/search.svg', width: 24, height: 24)),
              ),
            ),
            MenuIconButton(onTap: () => _onItemTapped(2), assetPath: 'assets/icons/message.svg', iconText: 'Messages', isSelected: _isSelected(2)),
            MenuIconButton(onTap: () => _onItemTapped(3), assetPath: 'assets/icons/profile.svg', iconText: 'Profile', isSelected: _isSelected(3)),
          ],
        ),
      ),
    );
  }
}
