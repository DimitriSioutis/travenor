import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bottom_bar_pages/calendar_page.dart';
import '../../../bottom_bar_pages/messages_page.dart';
import '../../../bottom_bar_pages/profile_page.dart';
import '../../../weather/presentation/bloc/weather_bloc.dart';
import '../../../weather/presentation/bloc/weather_event.dart';
import '../../../weather/presentation/widgets/weather_widget.dart';
import '../widgets/center_button.dart';
import 'home_page.dart';
import '../widgets/menu_icon_button.dart';
import '../widgets/profile_name_box.dart';

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
      context.read<WeatherBloc>().add(WeatherRequested());
      _selectedIndex = index;
    });
  }

  bool _isSelected(int index) {
    return _selectedIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileNameBox(),
            WeatherWidget(),
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        height: 100 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
            CenterButton(),
            MenuIconButton(onTap: () => _onItemTapped(2), assetPath: 'assets/icons/message.svg', iconText: 'Messages', isSelected: _isSelected(2)),
            MenuIconButton(onTap: () => _onItemTapped(3), assetPath: 'assets/icons/profile.svg', iconText: 'Profile', isSelected: _isSelected(3)),
          ],
        ),
      ),
    );
  }
}
