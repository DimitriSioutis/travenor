import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();
  @override
  List<Object> get props => [];
}

class ForgetPasswordRequested extends ForgetPasswordEvent {
  final String email;
  const ForgetPasswordRequested(this.email);
  @override
  List<Object> get props => [email];
}
