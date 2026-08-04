import 'package:spotify_clone/features/home/model/models/song_model.dart';

class UserModel {
  final String email;
  final String name;
  final String id;
  final String token;
  final List<SongModel> favourites;
  const UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
    required this.favourites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      token: json['token'] ?? '',
      favourites:
          (json['favourites'] as List<dynamic>?)
              ?.map((e) => SongModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'id': id,
      'token': token,
      'favourites': favourites.map((e) => e.toJson()).toList(),
    };
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? id,
    String? token,
    List<SongModel>? favourites,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      token: token ?? this.token,
      favourites: favourites ?? this.favourites,
    );
  }
}
