import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/MoviesReults.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'overview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MoviesReults data;
  double rating = 0.0;
  fetchMovie() async {
    var response = await http.get(
        'https://api.themoviedb.org/3/discover/movie?page=1&api_key=7f8feac9c848bbf3ba5b99ebeac12f20');
    var responsejson = json.decode(response.body);
    setState(() {
      data = MoviesReults.fromJson(responsejson);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.results.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SecondScreen(value: data.results[i])),
                  );
                },
                child: Container(
                    child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/' +
                            data.results[i].poster_path,
                        width: 118.0,
                        height: 103.0,
                        fit: BoxFit.fill,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  data.results[i].title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    new StarRating(
                                        rating:
                                            (data.results[i].vote_average) / 2,
                                        starConfig: StarConfig(
                                            size: 15.0,
                                            fillColor: Colors.orangeAccent),
                                        spaceBetween: 4.0)
                                  ],
                                ),
                              ]),
                        ),
                      )
                    ],
                  )
                ])),
              )),
            );
          },
        ));
  }
}
