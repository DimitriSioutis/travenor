import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';
import '../../domain/repositories/remote_config_repository.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;
  RemoteConfigRepositoryImpl({FirebaseRemoteConfig? remoteConfig}) : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final Map<String, OnboardingPageInfo> _pagesInfo = const {
    'onboard1': OnboardingPageInfo(
      title: 'Life is short and the world is ',
      lastWord: 'wide',
      description: 'At Friends tours and travel, we customize reliable and trutworthy educational tours to destinations all over the world',
      imageLocalPath: 'assets/images/board1.png',
    ),
    'onboard2': OnboardingPageInfo(
      title: 'It’s a big world out there go ',
      lastWord: 'explore',
      description: 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
      imageLocalPath: 'assets/images/board2.jpg',
    ),
    'onboard3': OnboardingPageInfo(
      title: 'People don’t take trips, trips take ',
      lastWord: 'people',
      description: 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
      imageLocalPath: 'assets/images/board3.jpg',
    ),
  };

  @override
  Future<List<OnboardingPageInfo>> getOnboardingPages() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 0),
        ),
      );
      await _remoteConfig.fetchAndActivate();
      final String pageOrderString = _remoteConfig.getString('onboard_order');
      if (pageOrderString.isEmpty) {
        return [_pagesInfo['onboard1']!, _pagesInfo['onboard2']!, _pagesInfo['onboard3']!];
      }

      final List<String> pageKeys = pageOrderString.split(',');
      final List<OnboardingPageInfo> orderedInfoPages = pageKeys.map((key) => _pagesInfo[key.trim()]).whereType<OnboardingPageInfo>().toList();

      return orderedInfoPages;
    } catch (e) {
      return [_pagesInfo['onboard1']!, _pagesInfo['onboard2']!, _pagesInfo['onboard3']!];
    }
  }
}
