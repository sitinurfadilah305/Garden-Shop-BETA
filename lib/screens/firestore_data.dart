import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'checkout.dart' as check;
import 'about.dart' as about;
import 'chat.dart' as chat;

void main() {
  runApp(MaterialApp(
    home: new UploadFirestore(),
    routes: <String, WidgetBuilder>{},
  ));
}

class UploadFirestore extends StatefulWidget {
  UploadFirestore({this.email});
  final String email;

  @override
  _UploadFirestoreState createState() => _UploadFirestoreState();
}

class _UploadFirestoreState extends State<UploadFirestore> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('user').snapshots();

    FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Pesanan'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new chat.MainPage(),
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new check.Checkout(),
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new about.About(),
                    ),
                  );
                }),
          ],
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.black38,
        body: Stack(
          children: [
            SizedBox(
              height: 150,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Card(
                        elevation: 50,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(children: <Widget>[
                                Text(
                                  document['tanaman'],
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(" : "),
                                Text(
                                  document['harga'].toString(),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    document['email'],
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
