import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/providers/user_model_notifier.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';
import 'package:spotify_clone/features/home/model/repos/home_repo.dart';
import 'package:spotify_clone/features/home/model/repos/local_home_repo.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getSongs(Ref ref) async {
  final homeRepo = ref.watch(homeRepoProvider);
  final token = ref.watch(
    userModelNotifierProvider.select((user) => user!.token),
  );
  final result = await homeRepo.getSongs(token: token);
  return result.fold((l) => throw Exception(l.message), (r) => r);
}

@riverpod
Future<List<SongModel>> getFavoriteSongs(Ref ref) async {
  final homeRepo = ref.watch(homeRepoProvider);
  final token = ref.watch(userModelNotifierProvider)!.token;
  final result = await homeRepo.getFavoriteSongs(token: token);
  return result.fold((l) => throw Exception(l.message), (r) => r);
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepo _homeRepo;
  late LocalHomeRepo _localHomeRepo;
  @override
  AsyncValue? build() {
    _homeRepo = ref.watch(homeRepoProvider);
    _localHomeRepo = ref.watch(localHomeRepoProvider);
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

  List<SongModel> getLocalSongs() {
    return _localHomeRepo.getSongs();
  }

  Future<void> toggleFavorite(String songId) async {
    final result = await _homeRepo.toggleFavorite(
      token: ref.read(userModelNotifierProvider)!.token,
      songId: songId,
    );

    result.fold(
      (l) {
      },
      (message) {
        final user = ref.read(userModelNotifierProvider)!;
        if (message == "Removed") {
          final updatedUser = user.copyWith(
            favourites: user.favourites
                .where((song) => song.id != songId)
                .toList(),
          );
          ref.read(userModelNotifierProvider.notifier).setUser(updatedUser);
        } else {
          final song = _localHomeRepo.getSongs().firstWhere(
            (song) => song.id == songId,
          );
          final updatedUser = user.copyWith(
            favourites: [...user.favourites, song],
          );
          ref.read(userModelNotifierProvider.notifier).setUser(updatedUser);
        }
        ref.invalidate(getFavoriteSongsProvider);
      },
    );
  }
}
