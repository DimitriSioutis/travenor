import '../models/travenor_user.dart';

abstract class AuthRepository {
  Future<TravenorUser> signUp({required String email, required String password, required String username});
  Future<TravenorUser> signIn({required String email, required String password});
  Future<TravenorUser> getTravenorUser(String uid);
  Future<void> signOut();
  Future<void> forgetPassword({required String email});
}
