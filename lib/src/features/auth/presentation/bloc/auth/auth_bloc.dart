import 'package:bloc/bloc.dart';
import '../../../domain/models/travenor_user.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository}) : _authRepository = authRepository, super(Unauthenticated()) {
    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        emit(Unauthenticated());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        TravenorUser travenorUser = await _authRepository.signIn(email: event.email, password: event.password);
        emit(Authenticated(travenorUser));
      } catch (e) {
        emit(AuthFailure('Your email or password is incorrect.'));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final travenorUser = await _authRepository.signUp(username: event.username, email: event.email, password: event.password);
        emit(Authenticated(travenorUser));
      } catch (e) {
        emit(AuthFailure('Failed to create account.'));
      }
    });

    on<SignOutRequested>((event, emit) async {
      try {
        await _authRepository.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthFailure('Failed to sign out.'));
      }
    });
  }
}
