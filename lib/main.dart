
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Connect Mysql'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  final TextEditingController _filter = new TextEditingController();


  String _searchText = "";
  List filterednames = new List(); // names we get from API
  List data = new List(); // names filtered by search text
  List name = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Json Search' );

  _MyHomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filterednames = name;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Future<String> getData() async {
    var response = await https.get(
      Uri.encodeFull("https://swapi.co/api/people/"),
        headers: {
          "Accept": "application/json"
        }
    );

    setState(() {
      var converteddata = jsonDecode(response.body);
      data = converteddata['results'];
      name = data;
      filterednames = name;

    });

    print(data[0]['name']);

    return "Success!";
  }

//  Future agetData() async{
//    var url = "https://readysteadypoo.000webhostapp.com/get.php";
//    https.Response response = await https.get(url);
//    var data = jsonDecode(response.body);
//    var list = data.toString().split(',');
//    return 'Succes';
//  }

  @override
  void initState() {
    super.initState();
    getData();
    //agetData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: _searchIcon,
          onPressed: (){
            _SearchPressed();
          },
        ),
        title: _appBarTitle,
        centerTitle: true,
      ),

      body: _buildList(),
    );
  }

  Widget _buildList(){
    if (!(_searchText.isEmpty)) {
      List data = new List();
      for (int i = 0; i <filterednames.length; i++) {
        if (filterednames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          data.add(filterednames[i]);
        }
      }
      filterednames = data;
    }
      return ListView.builder(
        itemCount: name == null ? 0 : filterednames.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: ListTile(
              title: Text(filterednames[index]['name'],
                style: TextStyle(color: Colors.pink, fontSize: 20.0,),),
              subtitle: Text(filterednames[index]['gender']),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          title: Text("Alert!!!"),
                          content: Text("Hello ${filterednames[index]['name']}")
                      );
                    }
                );
              },
            ),
          );
        },
      );


  }

  void _SearchPressed() {

    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Json Search');
        filterednames = name;
        _filter.clear();
      }
    });
  }
}
