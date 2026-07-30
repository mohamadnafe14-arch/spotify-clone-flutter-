import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/consts/server_constants.dart';
import 'package:spotify_clone/core/errorss/failure.dart';
part 'home_repo.g.dart';

@riverpod
HomeRepo homeRepo(Ref ref) => HomeRepo();

class HomeRepo {
  Future<Either<Failure, String>> uploadSong({
    required File thumbnail,
    required File song,
    required String songName,
    required String artist,
    required Color color,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/song/upload'),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath('thumbnail', thumbnail.path),
          await http.MultipartFile.fromPath('song', song.path),
        ])
        ..fields.addAll({
          'songName': songName,
          'artist': artist,
          'color': color.hex,
        })
        ..headers.addAll({'x-auth-token': token});
      final response = await request.send();
      if (response.statusCode != 201) return Left(Failure("error"));
      return Right("done");
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
