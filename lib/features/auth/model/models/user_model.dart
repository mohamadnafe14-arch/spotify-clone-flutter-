class UserModel {
  final String email;
  final String name;
  final String id;
  final String token;
  const UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'id': id};
  }

  UserModel copyWith({String? email, String? name, String? id, String? token}) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
