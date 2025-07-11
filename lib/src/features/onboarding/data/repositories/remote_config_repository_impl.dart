import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../domain/repositories/remote_config_repository.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  // TODO find better way to do this

  @override
  Future<List<String>> getOnBoardingPagesOrder() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );

    await remoteConfig.setDefaults(const {
      'onboarding_flow_order': '["onboard1", "onboard2", "onboard3"]',
    });

    await remoteConfig.fetchAndActivate();
    final jsonString = remoteConfig.getString('onboard_order');
    final List<dynamic> decodedList = jsonDecode(jsonString);
    final order = decodedList.cast<String>();
    return order;
  }
}
