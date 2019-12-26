import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:project_flutter/main.dart';


class create_data extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _Create();
  }

}

class _Create extends State<create_data>{

  final TextEditingController Name = new TextEditingController();
  final TextEditingController Address = new TextEditingController();

  final TextEditingController Phone = new TextEditingController();
  final TextEditingController Gender = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Informatin", style: TextStyle(color: Colors.white, fontSize: 16.0),),
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
                  child: Text("Add Data"),
                  onPressed: () {
                    addData();
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

  void addData() {

    if(!Name.text.isEmpty && !Address.text.isEmpty && !Phone.text.isEmpty && !Gender.text.isEmpty){

      var url = "https://readysteadypoo.000webhostapp.com/adddata.php";

      http.post(url, body:{
        "name":Name.text,
        "address": Address.text,
        "number": Phone.text,
        "gender": Gender.text,
      });

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return MyApp();
      }));
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: [
                  FlatButton(
                    child: Text("OK"),
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