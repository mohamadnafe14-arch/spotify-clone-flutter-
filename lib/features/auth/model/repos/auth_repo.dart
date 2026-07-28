import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/consts/server_constants.dart';
import 'package:spotify_clone/core/errorss/failure.dart';
import 'package:spotify_clone/features/auth/model/models/user_model.dart';
import 'package:http/http.dart' as http;
part 'auth_repo.g.dart';
@riverpod
AuthRepo authRepo(Ref ref) => AuthRepo();

class AuthRepo {
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
        return right(UserModel.fromJson(content));
      } else {
        return left(Failure(content["details"]));
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
        return right(UserModel.fromJson(content));
      } else {
        return left(Failure(content["details"]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
