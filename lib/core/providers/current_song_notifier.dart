import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  @override
  SongModel? build() => null;
  void setCurrentSong(SongModel song) async {
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(song.songUrl));
    await audioPlayer!.setAudioSource(audioSource);
    audioPlayer!.play();
    state = song;
  }
}
