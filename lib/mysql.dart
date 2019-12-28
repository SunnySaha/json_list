

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'dart:async';
import 'package:project_flutter/details.dart';
import 'package:project_flutter/create_data.dart';
import 'package:project_flutter/main.dart';

class mysql extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Mysql();
  }
}

class _Mysql extends State<mysql> {
  ScrollController _controller;
  List data = new List();
  String message = '';
  int index;

//  var list;
//  Future getData() async{
//    var url = "https://readysteadypoo.000webhostapp.com/get.php";
//    https.Response response = await https.get(url);
//
//   setState(() {
//
//     var data = jsonDecode(response.body);
//     list = data.toString().split(',');
//   });
//   for(int i = 0; i<list.length; i++){
//     print(list[i]);
//   }
//
//    return 'Succes';
//  }

  Future<String> getData() async {
    var response = await https.get(
        Uri.encodeFull("https://readysteadypoo.000webhostapp.com/get.php"),
        headers: {"Accept": "application/json"});

    setState(() {
      var converteddata = jsonDecode(response.body);
      data = converteddata;
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getData();
    _controller = ScrollController();
    _controller.addListener(showMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.white,),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return create_data();
              }));
            },
          ),
        ],
        title: Text("Data From Mysql $message"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        controller: _controller,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0),
            child: Container(
              height: 120,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListTile(
                  trailing:GestureDetector(
                    child: Icon(Icons.delete_forever, color: Colors.red,),

                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                actions: [
                                  FlatButton(
                                    child: Text("Close.."),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Want To delete?"),
                                    onPressed: () {

                                      Navigator.of(context).pop();

                                     var url = 'https://readysteadypoo.000webhostapp.com/delete.php';
                                     https.post(url, body: {
                                       "id": data[index]['id'],
                                     });

                                     showDialog(
                                         context: context,
                                         builder: (BuildContext context) {
                                           return AlertDialog(
                                               actions: [
                                                 FlatButton(
                                                   child: Text("OK"),
                                                   onPressed: () {
                                                     Navigator.of(context).pop();
                                                     getData();
                                                   },
                                                 ),
                                               ],
                                               title: Text("Success", style: (TextStyle(color: Colors.blue, fontSize: 19.0)),),
                                               content: Text("Data Deleted Successfully"));
                                         });

                                    },
                                  )
                                ],
                                title: Text("Warning", style: (TextStyle(color: Colors.red, fontSize: 20.0)),),
                                content: Text("Want to Delete ${data[index]['name']}?", style: (TextStyle(color: Colors.black, fontSize: 16.0)),));
                          });
                    },

                  ),


                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            details(data: data, index: index)),
                  ),
                  title: Text(
                    data[index]['name'],
                    style: TextStyle(color: Colors.purple, fontSize: 22.0),
                  ),
                  subtitle: Text(
                    data[index]['gender'],
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
                  ),
                ),

//              child: Container(
//                height: 150,
//                child: Padding(
//                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
//                  child: Row(
//
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text("Identification ${data[index]['id']}", style: TextStyle(color: Colors.purple, fontSize: 15.0),),
//                          SizedBox(height: 20.0,),
//                          Text(data[index]['name'],style: TextStyle(color: Colors.purple, fontSize:19.0),),
//                          SizedBox(height: 20.0,),
//                          Text(data[index]['address'],style: TextStyle(color: Colors.purple, fontSize: 16.0),),
//                        ],
//                      ),
//
//
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text("Contact: ${data[index]['number']}", style: TextStyle(color: Colors.purple, fontSize: 18.0),),
//                          SizedBox(height: 20.0,),
//                          Text(data[index]['gender'],style: TextStyle(color: Colors.purple, fontSize: 17.0),),
//
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
              ),
            ),
          );
        },
      ),
//      floatingActionButton:
//          FloatingActionButton(child: Icon(Icons.add), onPressed: () {
//
//          },
//            foregroundColor: Colors.white,
//            backgroundColor: Colors.redAccent[600],
//
//          ),
    );
  }

  void showMessage() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "Reach the Bottom";
//        Fluttertoast.showToast(
//            msg: "Reach the bottom",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            backgroundColor: Colors.indigo,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "Reach the Top";

//        Fluttertoast.showToast(
//            msg: "Reach the Top",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.indigo,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
      });
    }
  }


}
