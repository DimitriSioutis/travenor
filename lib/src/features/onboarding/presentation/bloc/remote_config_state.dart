import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object> get props => [];
}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigSuccess extends RemoteConfigState {
  final List<Widget> onboardPages;

  const RemoteConfigSuccess({required this.onboardPages});

  @override
  List<Object> get props => [onboardPages];
}

class RemoteConfigFailure extends RemoteConfigState {
  final String error;

  const RemoteConfigFailure(this.error);

  @override
  List<Object> get props => [error];
}
