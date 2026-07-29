import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/consts/server_constants.dart';
import 'package:spotify_clone/core/errorss/failure.dart';
import 'package:spotify_clone/features/auth/model/models/user_model.dart';
import 'package:http/http.dart' as http;
part 'auth_remote_repo.g.dart';

@riverpod
AuthRemoteRepo authRepo(Ref ref) => AuthRemoteRepo();

class AuthRemoteRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );
      final content = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(
          UserModel.fromJson(content["user"]).copyWith(token: content["token"]),
        );
      } else {
        return left(Failure(content["detail"]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/signUp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password, "name": name}),
      );
      final content = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return right(
          UserModel.fromJson(content).copyWith(token: content["token"]),
        );
      } else {
        return left(Failure(content["detail"]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> getCurrentUser({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/auth/getCurrentUser"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      final content = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(UserModel.fromJson(content).copyWith(token: token));
      } else {
        return left(Failure(content["detail"]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
