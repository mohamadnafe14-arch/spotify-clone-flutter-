import 'package:flutter/material.dart';
import 'package:spotify_clone/core/functions/color_hex_conversion.dart';

class SongModel {
  final String id;
  final String songName;
  final String thumbnailUrl;
  final String songUrl;
  final String artist;
  final Color color;

  const SongModel({
    required this.id,
    required this.songName,
    required this.thumbnailUrl,
    required this.songUrl,
    required this.artist,
    required this.color,
  });
  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    id: json["id"],
    songName: json["song_name"],
    thumbnailUrl: json["thumbnail_url"],
    songUrl: json["song_url"],
    artist: json["artist"],
    color: hexToColor(json["color_hex"]),
  );
  SongModel copyWith({
    String? id,
    String? songName,
    String? thumbnailUrl,
    String? songUrl,
    String? artist,
    Color? color,
  }) {
    return SongModel(
      id: id ?? this.id,
      songName: songName ?? this.songName,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      songUrl: songUrl ?? this.songUrl,
      artist: artist ?? this.artist,
      color: color ?? this.color,
    );
  }
}
