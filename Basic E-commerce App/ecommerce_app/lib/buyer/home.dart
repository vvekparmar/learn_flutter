import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _CurrentIndex = 0;
  List data;
  void fetchData() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('Products');
    collectionReference.snapshots().listen((snapshot) {
      data = snapshot.documents;
    });
  }

  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 211, 211, 1),
      body: SafeArea(
        child: Swiper(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.84,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: Swiper(
                            itemCount: data[index]['imageUrls'].length,
                            itemBuilder: (BuildContext context, int ind) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        data[index]['imageUrls'][ind]),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            data[index]['itemName'],
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            data[index]['companyName'],
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            data[index]['sellerName'],
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black12,
        color: Colors.grey,
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
