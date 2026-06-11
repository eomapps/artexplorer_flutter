class Artwork {
  final int? id;
  final String title;
  final String artistDisplay;
  final String dateDisplay;
  final String imageId;
  final List<String> styleTitles;
  final String placeOfOrigin;

  Artwork({
    this.id,
    required this.title,
    required this.artistDisplay,
    required this.dateDisplay,
    required this.imageId,
    required this.styleTitles,
    required this.placeOfOrigin,
  });

  factory Artwork.fromMap(Map<String, dynamic> map) {
    return Artwork(
      title: map['title'] as String,
      artistDisplay: map['artist_display'] as String,
      dateDisplay: map['date_display'] as String,
      imageId: map['image_id'] as String,
      styleTitles: map['style_titles'] as List<String>,
      placeOfOrigin: map['place_of_origin'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'artist_display': artistDisplay,
      'date_display': dateDisplay,
      'image_id': imageId,
      'style_titles': styleTitles,
      'place_of_origin': placeOfOrigin,
    };
  }

  Artwork copyWith({
    int? id,
    String? title,
    String? artistDisplay,
    String? dateDisplay,
    String? imageId,
    List<String>? styleTitles,
    String? placeOfOrigin,
  }) {
    return Artwork(
      id: id ?? this.id,
      title: title ?? this.title,
      artistDisplay: artistDisplay ?? this.artistDisplay,
      dateDisplay: dateDisplay ?? this.dateDisplay,
      imageId: imageId ?? this.imageId,
      styleTitles: styleTitles ?? this.styleTitles,
      placeOfOrigin: placeOfOrigin ?? this.placeOfOrigin,
    );
  }
}
