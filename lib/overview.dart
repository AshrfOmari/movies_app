import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatelessWidget {
  var value;

  SecondScreen({this.value});

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Description of Movies"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://image.tmdb.org/t/p/w500/' + value.backdrop_path,
                  height: 321.0,
                  width: 450.0,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 10.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(value.title, style: TextStyle(fontSize: 26.0)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                        child: Row(
                          children: <Widget>[
                            StarRating(
                              rating: (value.vote_average) / 2,
                              starConfig: StarConfig(size: 15.0),
                              spaceBetween: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Text(DateFormat('MMMM dd, yyyy ')
                                  .format(DateTime.parse(value.release_date)),style: TextStyle(color:Colors.grey[700] ),),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        value.overview,
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
