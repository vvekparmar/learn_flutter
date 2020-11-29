import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: NewsTemplate(),
    );
  }
}

class NewsTemplate extends StatefulWidget {
  @override
  _NewsTemplateState createState() => _NewsTemplateState();
}

class _NewsTemplateState extends State<NewsTemplate> {
  int _CurrentIndex = 0;
  final String url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=f8c15ba22b0b4ec08dd9f84c3480d709";
  Map<String, dynamic> map;
  List<dynamic> data;

  Future<String> fetchNews() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    map = json.decode(response.body);
    data = map['articles'];
  }

  @override
  void initState() {
    super.initState();
    this.fetchNews();
  }

  String lastIndex(int index) {
    if (data.length != index + 1) {
      return data[index + 1]['title'];
    } else {
      return data[index]['title'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Swiper(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: Card(
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(data[index]['urlToImage']),
                        ),
                        SizedBox(height: 20),
                        Text(
                          data[index]['title'],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          data[index]['description'],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Colors.grey,
                    child: Text(
                      lastIndex(index),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15,color: Colors.black),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.black12,
        color: Colors.black,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.bookmark, size: 20),
          Icon(Icons.notifications, size: 20),
          Icon(Icons.person, size: 20),
        ],
        onTap: (index) {
          _CurrentIndex = index;
        },
      ),
    );
  }
}
