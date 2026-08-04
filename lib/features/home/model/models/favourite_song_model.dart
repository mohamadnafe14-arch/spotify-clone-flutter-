class FavouriteSongModel {
  final String id;
  final String userId;
  final String songId;

  const FavouriteSongModel({
    required this.id,
    required this.userId,
    required this.songId,
  });

  factory FavouriteSongModel.fromJson(Map<String, dynamic> json) =>
      FavouriteSongModel(
        id: json["id"],
        userId: json["user_id"],
        songId: json["song_id"],
      );
  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "song_id": songId,
  };
}
