import 'package:equatable/equatable.dart';

abstract class RemoteConfigEvent extends Equatable {
  const RemoteConfigEvent();

  @override
  List<Object> get props => [];
}

class InitializeAndFetchConfig extends RemoteConfigEvent {}
