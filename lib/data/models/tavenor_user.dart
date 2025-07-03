import 'package:equatable/equatable.dart';

class TravenorUser extends Equatable {
  final String uid;
  final String username;
  final String email;

  const TravenorUser({
    required this.uid,
    required this.username,
    required this.email,
  });

  factory TravenorUser.fromMap(Map<String, dynamic> map) {
    return TravenorUser(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
  @override
  List<Object?> get props => [uid, username, email];
}
