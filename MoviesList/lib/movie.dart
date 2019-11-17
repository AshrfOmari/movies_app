import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String poster_path;
  final num vote_average;
  final String overview;
  final String backdrop_path;
  final String release_date;

  Movie({this.title, this.poster_path, this.vote_average , this.overview,this.backdrop_path,this.release_date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      poster_path: json['poster_path'],
       vote_average: json['vote_average'],
       overview: json['overview'],
       backdrop_path:json['backdrop_path'],
       release_date:  json['release_date']
    );
  }
}
