import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String poster_path;
  final num vote_average;
  final String overview;
  final String backdrop_path;
  final String release_date;
  final int vote_count;
  final String original_language;
  final bool adult;
  final num popularity;
  dynamic fav_border = Icon(Icons.favorite_border);
  bool isFavorite = false;
  bool sFavorite = true;

  Movie({
    this.title,
    this.poster_path,
    this.vote_average,
    this.overview,
    this.backdrop_path,
    this.release_date,
    this.vote_count,
    this.original_language,
    this.adult,
    this.popularity,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      poster_path: json['poster_path'],
      vote_average: json['vote_average'],
      overview: json['overview'],
      backdrop_path: json['backdrop_path'],
      release_date: json['release_date'],
      vote_count: json['vote_count'],
      original_language: json['original_language'],
      adult: json['adult'],
      popularity: json['popularity'],
    );
  }
}
