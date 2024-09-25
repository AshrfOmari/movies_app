import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:movies/ClassOfMovies/MoviesReults.dart';
import 'package:movies/ClassOfMovies/movie.dart';
import 'DetailsOfMovies.dart';

class ListMovies extends StatefulWidget {
  ListMovies({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListMovies> {
  List<Movie> data = [];
  List<Movie> movies = [] ;
  double rating = 0.0;
  bool _isVisible = true;
  Icon fav = Icon(Icons.favorite_border);
  bool isLoading = false;
  int page = 1;
  String path =
      'https://api.themoviedb.org/3/discover/movie?page={page}&api_key=7f8feac9c848bbf3ba5b99ebeac12f20';

  fetchMovie(int pageNum) async {
    var response = await http.get(
        path.replaceAll('{page}', '$pageNum')); /* replace the page number*/
    var responsejson = json.decode(response.body);
    setState(() {
      data.addAll( MoviesReults.fromJson(responsejson).results) ;
      movies = data.toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovie(page);
  }

  void visiblity() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: (){
                setState(() {
                 
                });
              },
            ),
            IconButton(
              icon: fav,
              onPressed: () {
                setState(() {
                  if (data.length <= movies.length ) {
                    movies = movies.where((i) => i.isFavorite).toList();
                    fav = Icon(Icons.favorite); 
                  } else {
                    movies = data;
                    fav = Icon(Icons.favorite_border);
                  }
                  if (movies.isEmpty || fav == Icon(Icons.favorite_border)) {
                    visiblity();
                  }       
                });
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      if (data.length == movies.length) {         
                         fetchMovie(++page);
                        setState(() {
                          isLoading = true;
                        });
                      }
                    }
                  },
                  child: Visibility(
                      visible: _isVisible,
                      child: buildListView(),
                      replacement: Card(
                        elevation: 0.0,
                        color: Colors.black,
                        child: Center(
                          child: new Text(
                            'Dont Have Any Favorite Movies ',
                            style: TextStyle(color: Colors.red, fontSize: 28.0),
                          ),
                        ),
                      ))),
            ),
            Container(
              height: isLoading ? 30.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: 380.0,
                  height: 20.0,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      'Rest',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                  ))
            ],
          ),
        ));
  }

  ListView buildListView() {
    return new ListView.builder(
      itemCount: data == null ? 0 : movies.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
              color: Colors.black87,
              elevation: 0.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsOfMovies(value: movies[i])),
                  );
                },
                child: Container(
                    child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/' +
                            movies[i].poster_path,
                        width: 140.0,
                        height: 190.0,
                        fit: BoxFit.fitWidth,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  movies[i].title,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    new StarRating(
                                        rating: (movies[i].vote_average) / 2,
                                        starConfig: StarConfig(
                                            size: 20.0,
                                            fillColor: Colors.orangeAccent),
                                        spaceBetween: 4.0),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: movies[i].fav_border,
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                movies[i].isFavorite =
                                                    !movies[i].isFavorite;
                                                if (movies[i].isFavorite) {
                                                  movies[i].fav_border =
                                                      Icon(Icons.favorite);
                                                } else {
                                                  movies[i].fav_border = Icon(
                                                      Icons.favorite_border);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'Language : ' + movies[i].original_language,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.red),
                                ),
                                Text(
                                  'Votes : ' + '${movies[i].vote_count}',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                ),
                                Text(
                                  'Adult : ' + movies[i].adult.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(
                                    'Popularity : ' +
                                        '${movies[i].popularity / 100} ',
                                    style: TextStyle(color: Colors.red)),
                              ]),
                        ),
                      )
                    ],
                  )
                ])),
              )),
        );
      },
    );
  }
}
