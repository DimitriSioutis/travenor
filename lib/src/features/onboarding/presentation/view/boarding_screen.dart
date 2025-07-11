import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/features/onboarding/domain/repositories/remote_config_repository.dart';
import '../../../../constants/colors.dart';
import '../bloc/remote_config_bloc.dart';
import '../../../../common_widgets/general_button.dart';
import '../bloc/remote_config_event.dart';
import '../bloc/remote_config_state.dart';
import 'boarding_page.dart';
import '../widgets/boarding_indicator.dart';

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
      title: 'People don’t take trips, trips take ',
      lastWord: 'people',
      description: 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
      imageLocalPath: 'assets/images/board3.jpg',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteConfigBloc>(
      create: (context) => RemoteConfigBloc(remoteConfigRepository: context.read<RemoteConfigRepository>())..add(InitializeAndFetchConfig()),
      child: Scaffold(
        backgroundColor: bgColor,
        body: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
          builder: (context, state) {
            if (state is RemoteConfigLoading || state is RemoteConfigInitial) {
              return const Center(child: CircularProgressIndicator(color: mainColor));
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
                    child: GeneralButton(
                      buttonText: _currentPageIndex == 0 ? 'Get Started' : 'Next',

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

  Widget _buildPageIndicator(int pagesLength, int currentIndex) {
    List<Widget> list = [];
    for (int i = 0; i < pagesLength; i++) {
      list.add(
        BoardingIndicator(
          isActive: i == currentIndex ? true : false,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
