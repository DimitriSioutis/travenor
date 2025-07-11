import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'remote_config_event.dart';
import 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  RemoteConfigBloc() : super(RemoteConfigInitial()) {
    on<InitializeAndFetchConfig>((event, emit) async {
      emit(RemoteConfigLoading());
      try {
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

        emit(RemoteConfigSuccess(onboardOrder: order));
      } catch (e) {
        emit(RemoteConfigFailure(e.toString()));
      }
    });
  }
}
