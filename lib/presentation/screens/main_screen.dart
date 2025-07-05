import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/constants.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../logic/blocs/auth/auth_bloc.dart';
import '../../logic/blocs/auth/auth_event.dart';
import '../../logic/blocs/auth/auth_state.dart';
import '../../logic/blocs/favorites/favorites_bloc.dart';
import '../../logic/blocs/favorites/favorites_event.dart';
import 'bottom_bar_pages/calendar_page.dart';
import 'bottom_bar_pages/home_page.dart';
import 'bottom_bar_pages/messages_page.dart';
import 'bottom_bar_pages/profile_page.dart';
import 'bottom_bar_pages/search_page.dart';

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
    SearchPage(),
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
        title: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }
          },
          builder: (context, authState) {
            if (authState is Authenticated) {
              context.read<FavoritesBloc>().add(LoadFavorites(authState.user.uid));
              return InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
                child: Container(
                  decoration: BoxDecoration(color: lightGrey, borderRadius: BorderRadius.circular(22)),
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: grey,
                        radius: 18.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          authState.user.username,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: blackText),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Text('Home');
          },
        ),
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
              onTap: () => _onItemTapped(2),
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
            MenuIconButton(onTap: () => _onItemTapped(3), assetPath: 'assets/icons/message.svg', iconText: 'Messages', isSelected: _isSelected(3)),
            MenuIconButton(onTap: () => _onItemTapped(4), assetPath: 'assets/icons/profile.svg', iconText: 'Profile', isSelected: _isSelected(4)),
          ],
        ),
      ),
    );
  }
}

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.assetPath,
    required this.onTap,
    required this.iconText,
    required this.isSelected,
  });

  final String assetPath;
  final VoidCallback onTap;
  final String iconText;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(assetPath, width: 24, height: 24, color: isSelected ? mainColor : grey),
          SizedBox(height: 8),
          Text(
            iconText,
            style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w500, color: isSelected ? mainColor : grey),
          ),
        ],
      ),
    );
  }
}
