import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_flutter/main.dart';

class edit extends StatefulWidget {
  List data;
  int index;

  edit({this.data, this.index});

  @override
  State<StatefulWidget> createState() {
    return _Edit();
  }
}

class _Edit extends State<edit> {
  TextEditingController Name = new TextEditingController();
  TextEditingController Address = new TextEditingController();

  TextEditingController Phone = new TextEditingController();
  TextEditingController Gender = new TextEditingController();

  @override
  void initState() {

    super.initState();
    Name = TextEditingController(text: widget.data[widget.index]['name']);
    Address = TextEditingController(text: widget.data[widget.index]['address']);
    Phone = TextEditingController(text: widget.data[widget.index]['number']);
    Gender = TextEditingController(text: widget.data[widget.index]['gender']);
    print(widget.data[widget.index]['id']);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Informatin",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: Name,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Name',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: Address,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: Phone,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Numebr',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: Gender,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onPressed: () {
                    EditData();
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
    ;
  }

  void EditData() {
    if (!Name.text.isEmpty &&
        !Address.text.isEmpty &&
        !Phone.text.isEmpty &&
        !Gender.text.isEmpty) {
      var url = "https://readysteadypoo.000webhostapp.com/editdata.php";

      http.post(url, body: {
        "id": widget.data[widget.index]['id'],
        "name": Name.text,
        "address": Address.text,
        "number": Phone.text,
        "gender": Gender.text,
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: [
                  FlatButton(
                    child: Text("Go To Home"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MyApp();
                      }));
                    },
                  ),
                ],
                title: Text("Success"),
                content: Text("Your Data is Updating Successfully"));
          });

    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: [
                  FlatButton(
                    child: Text("GOT IT!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                title: Text("Try Again..."),
                content: Text("All Fields should be Fill up"));
          });
    }
  }
}
