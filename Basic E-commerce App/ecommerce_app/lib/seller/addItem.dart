import 'package:ecommerce_app/seller/signout.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String sellerName, companyName, productName;
  List<Asset> images = List<Asset>();
  List<String> imageUrls = List<String>();
  bool isUploading = false;

  Widget buildGridView() {
    if (images != null) {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index] as Asset;
          return AssetThumb(
            asset: asset,
            width: 200,
            height: 200,
          );
        }),
      );
    } else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 6,
          enableCamera: false,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: 'chat'));
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    firebase_storage.UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipPath(
                      clipper: SideClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.lightBlueAccent
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: OvalClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(5, 5),
                              blurRadius: 1.0,
                              spreadRadius: 1.0)
                        ],
                        gradient: LinearGradient(colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent,
                          Colors.blue,
                          Colors.blue
                        ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 55),
                    child: Text("Add Item",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.dehaze),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Product Name",
                      ),
                      onChanged: (value) {
                        setState(() {
                          productName = value.trim();
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Seller Name",
                      ),
                      onChanged: (value) {
                        setState(() {
                          sellerName = value.trim();
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.domain),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Company Name",
                      ),
                      onChanged: (value) {
                        setState(() {
                          companyName = value.trim();
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        textColor: Colors.lightBlueAccent,
                        color: Colors.transparent,
                        child: Text("Select Images",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        onPressed: loadAssets,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: buildGridView(),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        child: Text("Add Item",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "Wait Sometime...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM_RIGHT,
                          );
                          Map<String, dynamic> data = {
                            "itemName": productName,
                            "sellerName": sellerName,
                            "companyName": companyName,
                            "imageUrls" : imageUrls,
                           };
                          for (var imageFile in images) {
                            postImage(imageFile).then((downloadUrl) {
                              imageUrls.add(downloadUrl.toString());
                              if (imageUrls.length == images.length) {
                                String documentID = DateTime.now().millisecondsSinceEpoch.toString();
                                Firestore.instance
                                    .collection('Products')
                                    .document(documentID)
                                    .setData(data).then((_) {
                                  setState(() {
                                    images = [];
                                    imageUrls = [];
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => SellerSignOutPage()));
                                  });
                                });
                              }
                            }).catchError((err) {
                              print(err);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SideClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 2 / 5;
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);
    final roundingRectangle = Rect.fromLTRB(
        0, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);
    path.arcTo(roundingRectangle, 3.14, -3.14, true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final roundingHeight = size.height * 1;
    final roundingRectangle = Rect.fromLTRB(
        -100, size.height - roundingHeight * 2, size.width, size.height);
    path.arcTo(roundingRectangle, 3.14, -3.14, true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}
