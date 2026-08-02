import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/providers/user_model_notifier.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';
import 'package:spotify_clone/features/home/model/repos/home_repo.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getSongs(Ref ref) async {
  final homeRepo = ref.watch(homeRepoProvider);
  final token = ref.watch(userModelNotifierProvider)!.token;
  final result = await homeRepo.getSongs(token: token);
  return result.fold((l) => throw Exception(l.message), (r) => r);
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepo _homeRepo;
  @override
  AsyncValue? build() {
    _homeRepo = ref.watch(homeRepoProvider);
    return null;
  }

  Future<void> uploadSong({
    required File thumbnail,
    required File song,
    required String songName,
    required String artist,
    required Color color,
  }) async {
    state = const AsyncLoading();
    final user = ref.read(userModelNotifierProvider.notifier).state!;
    final result = await _homeRepo.uploadSong(
      thumbnail: thumbnail,
      song: song,
      songName: songName,
      artist: artist,
      color: color,
      token: user.token,
    );
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}
