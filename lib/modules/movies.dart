class Movie {
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  String backdropPath;
  String releaseDate;
  List<int> genreIds;
  double popularity;
  double voteAverage;
  int voteCount;
  bool adult;
  String originalLanguage;
  String mediaType;
  bool video;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.originalLanguage,
    required this.mediaType,
    required this.video,
  });

  // Factory method to create a Movie from a JSON map
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      genreIds: List<int>.from(json['genre_ids']),
      popularity: json['popularity'].toDouble(),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      mediaType: json['media_type'],
      video: json['video'],
    );
  }

  // Method to convert the Movie object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'original_language': originalLanguage,
      'media_type': mediaType,
      'video': video,
    };
  }
}

class MoviesResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  // Factory method to create a MoviesResponse from a JSON map
  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      page: json['page'],
      results: (json['results'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  // Method to convert the MoviesResponse object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
