class Program {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<Track> tracks;

  Program({required this.id, required this.name, required this.description, required this.image, required this.tracks});

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      tracks: (json['tracks'] as List).map((track) => Track.fromJson(track)).toList(),
    );
  }
}

class Track {
  final String title;
  final String audioUrl;

  Track({required this.title, required this.audioUrl});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      title: json['title'],
      audioUrl: json['audioUrl'],
    );
  }
}
