class UserModel {
  final String email;
  final String name;
  final String id;

  const UserModel({
    required this.email,
    required this.name,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email,  'name': name, 'id': id};
  }
}
