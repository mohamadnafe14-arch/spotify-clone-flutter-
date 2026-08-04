import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/models/song_model.dart';
import 'package:spotify_clone/features/home/model/repos/local_home_repo.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late LocalHomeRepo _localHomeRepo;
  @override
  SongModel? build() {
    _localHomeRepo = ref.watch(localHomeRepoProvider);
    return null;
  }

  void setCurrentSong(SongModel song) async {
    await audioPlayer?.stop();
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(
      Uri.parse(song.songUrl),
      tag: MediaItem(
        id: song.id,
        title: song.songName,
        artist: song.artist,
        artUri: Uri.parse(song.thumbnailUrl),
      ),
    );
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
    _localHomeRepo.uploadSong(song);
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
