import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Template());
  }
}

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _CurrentIndex = 0;

  final String url =
      "http://www.teenagerstartups.com/media/featured-story-list/5";
  List data;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/logo.jpg'),
                radius: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 18, 0, 0),
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(100, 50, 255, 1),
                child: Icon(Icons.calendar_view_day),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Icon(Icons.forum, size: 33),
          )
        ],
        title: TextField(
          autocorrect: true,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search....",
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(Icons.tune),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    borderOnForeground: true,
                    color: Color.fromRGBO(232, 232, 232, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image.asset('images/logo.jpg'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "Story",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Image.network(data[index]['entrepreneur_image']),
                                Text(
                                  data[index]['title'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "By :- " +
                                      data[index]['contributor_name'] +
                                      " and " +
                                      data[index]['contributor_name_2'],
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data[index]['story_abstract'].toString(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data[index]['story_published_at'],
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _CurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(255, 220, 200, 1),
        iconSize: 30,
        unselectedItemColor: Colors.orange,
        selectedItemColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text("Network")),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive), title: Text("Points")),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text("Notifications")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Teengles"))
        ],
        onTap: (index) {
          setState(() {
            _CurrentIndex = index;
          });
        },
      ),
    );
  }
}