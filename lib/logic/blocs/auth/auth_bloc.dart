import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/tavenor_user.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository}) : _authRepository = authRepository, super(Unauthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        User user = await _authRepository.signIn(email: event.email, password: event.password);
        TravenorUser travenorUser = await _authRepository.getTravenorUser(user.uid);
        emit(Authenticated(travenorUser));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authRepository.signUp(username: event.username, email: event.email, password: event.password);

        final travenorUser = await _authRepository.getTravenorUser(user.uid);
        emit(Authenticated(travenorUser));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      // Do nothing
      await _authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}
