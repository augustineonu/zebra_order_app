


class UserInfo {
  final int id;
  final String firstname;
  final String lastname;
  final String imageUrl;
  final String email;

  const UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.imageUrl,
    required this.email

  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json['id'] as int,
        firstname: json['first_name'] as String,
        lastname: json['last_name'] as String,
        imageUrl: json['avatar'] as String, email: json['email'] as String,

    );
  }
}