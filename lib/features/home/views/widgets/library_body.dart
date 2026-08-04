import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/widgets/loader.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';
import 'package:spotify_clone/features/home/views/add_song_view.dart';

class LibraryBody extends ConsumerWidget {
  const LibraryBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getFavoriteSongsProvider)
        .when(
          data: (data) {
            final favoriteSongs = data;
            return ListView.builder(
              itemCount: favoriteSongs.length + 1,
              itemBuilder: ((context, index) {
                if (index == favoriteSongs.length) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddSongView(),
                        ),
                      );
                    },
                    leading: Icon(Icons.add),
                    title: Text(
                      "Upload your own music",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                final song = favoriteSongs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(song.thumbnailUrl),
                    radius: 35,
                  ),
                  title: Text(
                    song.songName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text("Error: $error"));
          },
          loading: () => const Loader(),
        );
  }
}
