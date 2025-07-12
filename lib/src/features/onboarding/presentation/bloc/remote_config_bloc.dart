import 'package:bloc/bloc.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';
import '../../domain/repositories/remote_config_repository.dart';
import 'remote_config_event.dart';
import 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final RemoteConfigRepository _remoteConfigRepository;
  RemoteConfigBloc({required RemoteConfigRepository remoteConfigRepository}) : _remoteConfigRepository = remoteConfigRepository, super(RemoteConfigInitial()) {
    on<InitializeAndFetchConfig>((event, emit) async {
      emit(RemoteConfigLoading());
      try {
        List<OnboardingPageInfo> infoList = await _remoteConfigRepository.getOnboardingPages();
        emit(RemoteConfigSuccess(infoList: infoList));
      } catch (e) {
        emit(RemoteConfigFailure(e.toString()));
      }
    });
  }
}
