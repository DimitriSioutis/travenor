import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';
import 'package:travenor/src/features/onboarding/domain/repositories/remote_config_repository.dart';
import '../../../../constants/colors.dart';
import '../bloc/remote_config_bloc.dart';
import '../../../../common_widgets/general_button.dart';
import '../bloc/remote_config_event.dart';
import '../bloc/remote_config_state.dart';
import '../widgets/boarding_page.dart';
import '../widgets/boarding_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteConfigBloc>(
      create: (context) => RemoteConfigBloc(remoteConfigRepository: context.read<RemoteConfigRepository>())..add(InitializeAndFetchConfig()),
      child: Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<RemoteConfigBloc, RemoteConfigState>(
          listener: (context, state) {
            if (state is RemoteConfigSuccess) {
              if (state.infoList.isEmpty) Navigator.pushReplacementNamed(context, '/login');
            }
          },
          builder: (context, state) {
            if (state is RemoteConfigLoading || state is RemoteConfigInitial) {
              return const Center(child: CircularProgressIndicator(color: mainColor));
            }

            if (state is RemoteConfigFailure) {
              return Center(child: Text('Error loading config: ${state.error}'));
            }

            if (state is RemoteConfigSuccess) {
              List<OnboardingPageInfo> infoList = state.infoList;
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.infoList.length,
                      onPageChanged: (value) {
                        setState(() {
                          _currentPageIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        final info = state.infoList[index];
                        return BoardPage(info: info);
                      },
                    ),
                  ),
                  _buildPageIndicator(infoList.length, _currentPageIndex),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: MediaQuery.of(context).padding.top),
                    child: GeneralButton(
                      buttonText: _currentPageIndex == 0 ? 'Get Started' : 'Next',
                      onTap: () {
                        if (_currentPageIndex == infoList.length - 1) {
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
