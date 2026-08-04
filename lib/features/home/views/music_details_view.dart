import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_song_notifier.dart';
import 'package:spotify_clone/core/providers/user_model_notifier.dart';
import 'package:spotify_clone/core/theme/app_palette.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';

class MusicDetailsView extends ConsumerWidget {
  const MusicDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongNotifierProvider);
    final currentSongNotifier = ref.read(currentSongNotifierProvider.notifier);
    final user = ref.watch(userModelNotifierProvider);
final isFavorite = user!.favourites.any(
  (song) => song.id == song.id,
);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [song?.color ?? Colors.black, Color(0x0ff12121)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Hero(
                  tag: "song_image",
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(song!.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              song.songName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              song.artist,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: isFavorite
                              ? const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            ref
                                .read(homeViewmodelProvider.notifier)
                                .toggleFavorite(song.id);
                          },
                        ),
                      ],
                    ),
                    StreamBuilder<Duration>(
                      stream: ref
                          .read(currentSongNotifierProvider.notifier)
                          .audioPlayer
                          ?.positionStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        final position = snapshot.data ?? Duration.zero;
                        final totalDuration =
                            currentSongNotifier.audioPlayer?.duration ??
                            Duration.zero;
                        final ratio = totalDuration.inSeconds == 0
                            ? 0.0
                            : position.inSeconds / totalDuration.inSeconds;
                        return Column(
                          children: [
                            Slider(
                              activeColor: Colors.white,
                              inactiveColor: Colors.grey,
                              thumbColor: Colors.white,
                              value: ratio,
                              max: 1.0,
                              min: 0.0,
                              onChanged: (value) {},
                              onChangeEnd: (value) {
                                currentSongNotifier.seekToPosition(value);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                                ),
                                Text(
                                  "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/shuffle.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/previus-song.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      currentSongNotifier.playOrPauseSong,
                                  icon: Icon(
                                    currentSongNotifier.isPlaying
                                        ? CupertinoIcons.pause_circle_fill
                                        : CupertinoIcons.play_circle_fill,
                                  ),
                                  iconSize: 80,
                                  color: Pallete.whiteColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/next-song.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/repeat.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/connect-device.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/playlist.png',
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
