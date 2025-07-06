import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../logic/blocs/remote_config/remote_config_bloc.dart';
import '../../../logic/blocs/remote_config/remote_config_event.dart';
import '../../../logic/blocs/remote_config/remote_config_state.dart';
import 'boarding_page.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final Map<String, Widget> _pages = const {
    'onboard1': BoardPage(
      title: 'Life is short and the world is ',
      lastWord: 'wide',
      description: 'At Friends tours and travel, we customize reliable and trutworthy educational tours to destinations all over the world',
      imageLocalPath: 'assets/images/board1.png',
    ),
    'onboard2': BoardPage(
      title: 'It’s a big world out there go ',
      lastWord: 'explore',
      description: 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
      imageLocalPath: 'assets/images/board2.jpg',
    ),
    'onboard3': BoardPage(
      title: 'People don’t take trips, trips take people',
      lastWord: 'people',
      description: 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
      imageLocalPath: 'assets/images/board3.jpg',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteConfigBloc>(
      create: (context) => RemoteConfigBloc()..add(InitializeAndFetchConfig()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
          builder: (context, state) {
            if (state is RemoteConfigLoading || state is RemoteConfigInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RemoteConfigFailure) {
              return Center(child: Text('Error loading config: ${state.error}'));
            }

            if (state is RemoteConfigSuccess) {
              final List<Widget> pages = state.onboardOrder.map((screenKey) {
                return _pages[screenKey]!;
              }).toList();
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: pages,
                      onPageChanged: (value) {
                        setState(() {
                          _currentPageIndex = value;
                        });
                      },
                    ),
                  ),
                  _buildPageIndicator(pages.length, _currentPageIndex),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: MediaQuery.of(context).padding.top),
                    child: InkWell(
                      onTap: () {
                        if (_currentPageIndex == pages.length - 1) {
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _currentPageIndex == 0 ? 'Get Started' : 'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int numPages, int currentIndex) {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 7.0,
      width: isActive ? 35.0 : 6.0,
      decoration: BoxDecoration(
        color: isActive ? mainColor : mainColor.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
