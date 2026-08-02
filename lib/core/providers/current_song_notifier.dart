import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  @override
  SongModel? build() => null;
  void setCurrentSong(SongModel song) async {
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(song.songUrl));
    await audioPlayer!.setAudioSource(audioSource);
    audioPlayer!.play();
    isPlaying = true;
    audioPlayer!.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;
        this.state = this.state?.copyWith(id: this.state?.id);
      }
    });
    state = song;
  }

  void playOrPauseSong() {
    if (isPlaying) {
      audioPlayer!.pause();
    } else {
      audioPlayer!.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(id: state?.id);
  }

  void seekToPosition(double value) {
    final position = audioPlayer!.duration! * value;
    audioPlayer!.seek(
      position.inSeconds.toDouble() == 0.0 ? Duration.zero : position,
    );
  }
}
