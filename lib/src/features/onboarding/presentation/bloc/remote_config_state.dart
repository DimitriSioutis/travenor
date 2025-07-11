import 'package:equatable/equatable.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object> get props => [];
}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigSuccess extends RemoteConfigState {
  final List<String> onboardOrder;

  const RemoteConfigSuccess({required this.onboardOrder});

  @override
  List<Object> get props => [onboardOrder];
}

class RemoteConfigFailure extends RemoteConfigState {
  final String error;

  const RemoteConfigFailure(this.error);

  @override
  List<Object> get props => [error];
}
