import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';
import '../../domain/repositories/remote_config_repository.dart';
import '../widgets/boarding_page.dart';
import 'remote_config_event.dart';
import 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final RemoteConfigRepository _remoteConfigRepository;
  RemoteConfigBloc({required RemoteConfigRepository remoteConfigRepository}) : _remoteConfigRepository = remoteConfigRepository, super(RemoteConfigInitial()) {
    on<InitializeAndFetchConfig>((event, emit) async {
      emit(RemoteConfigLoading());
      try {
        List<OnboardingPageInfo> infoList = await _remoteConfigRepository.getOnboardingPages();
        List<Widget> pages = infoList.map((info) => BoardPage(info: info)).toList();
        emit(RemoteConfigSuccess(onboardPages: pages));
      } catch (e) {
        emit(RemoteConfigFailure(e.toString()));
      }
    });
  }
}
