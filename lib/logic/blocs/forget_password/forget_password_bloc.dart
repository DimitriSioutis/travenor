import 'package:bloc/bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AuthRepository _authRepository;
  ForgetPasswordBloc({required AuthRepository authRepository}) : _authRepository = authRepository, super(ForgetPasswordInitial()) {
    on<ForgetPasswordRequested>((event, emit) async {
      emit(ForgetPasswordLoading());
      try {
        await _authRepository.forgetPassword(email: event.email);
        emit(ForgetPasswordSuccess());
      } catch (e) {
        emit(ForgetPasswordError(e.toString()));
      }
    });
  }
}
