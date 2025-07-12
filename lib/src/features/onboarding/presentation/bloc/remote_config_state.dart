import 'package:equatable/equatable.dart';
import '../../domain/models/onboarding_page.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object> get props => [];
}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigSuccess extends RemoteConfigState {
  final List<OnboardingPageInfo> infoList;

  const RemoteConfigSuccess({required this.infoList});

  @override
  List<Object> get props => [infoList];
}

class RemoteConfigFailure extends RemoteConfigState {
  final String error;

  const RemoteConfigFailure(this.error);

  @override
  List<Object> get props => [error];
}
