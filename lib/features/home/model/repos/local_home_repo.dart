import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';
part 'local_home_repo.g.dart';

@riverpod
LocalHomeRepo localHomeRepo(Ref ref) {
  return LocalHomeRepo();
}

class LocalHomeRepo {
  void uploadSong(SongModel song) {
    final songsBox = Hive.box('Songs');
    songsBox.put(song.id, song.toJson());
  }

  List<SongModel> getSongs() {
    final songsBox = Hive.box('Songs');
    List<SongModel> songs = [];
    for (var key in songsBox.keys) {
      final songJson = songsBox.get(key);
      final song = SongModel.fromJson(songJson);
      songs.add(song);
    }
    return songs;
  }
}
