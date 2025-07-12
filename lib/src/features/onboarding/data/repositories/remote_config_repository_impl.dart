import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';
import '../../domain/repositories/remote_config_repository.dart';
import '../../presentation/widgets/boarding_page.dart';

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
      final String jsonString = _remoteConfig.getString('onboard_order');
      final Map<String, dynamic> onBoardOrder = jsonDecode(jsonString);

      return [
        _pagesInfo[onBoardOrder['page1']] ?? _pagesInfo[onBoardOrder['onboard1']]!,
        _pagesInfo[onBoardOrder['page2']] ?? _pagesInfo[onBoardOrder['onboard2']]!,
        _pagesInfo[onBoardOrder['page3']] ?? _pagesInfo[onBoardOrder['onboard3']]!,
      ];
    } catch (e) {
      return [_pagesInfo['onboard1']!, _pagesInfo['onboard2']!, _pagesInfo['onboard3']!];
    }
  }
}
