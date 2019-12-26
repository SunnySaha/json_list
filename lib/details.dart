import 'package:flutter/material.dart';
import 'package:project_flutter/edit.dart';

class details extends StatefulWidget {
  List data;
  int index;

  details({this.data, this.index});

  @override
  State<StatefulWidget> createState() {
    return _Details();
  }
}

class _Details extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.data[widget.index]['name']}"),
      ),
      body: Center(
        child: Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Identification ${widget.data[widget.index]['id']}",
                  style: TextStyle(color: Colors.purple, fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Address: ${widget.data[widget.index]['address']}",
                  style: TextStyle(color: Colors.purple, fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Contact: ${widget.data[widget.index]['number']}",
                  style: TextStyle(color: Colors.purple, fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.data[widget.index]['gender'],
                  style: TextStyle(color: Colors.purple, fontSize: 20.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  child: Text("Update"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return edit(data: widget.data, index: widget.index);
                    }));
                  },
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
