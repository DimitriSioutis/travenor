import '../../domain/models/travenor_user.dart';

class TravenorUserModel {
  final String uid;
  final String username;
  final String email;

  const TravenorUserModel({
    required this.uid,
    required this.username,
    required this.email,
  });

  factory TravenorUserModel.fromMap(Map<String, dynamic> map) {
    return TravenorUserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  TravenorUser toDomain() {
    return TravenorUser(
      uid: uid,
      username: username,
      email: email,
    );
  }
}
