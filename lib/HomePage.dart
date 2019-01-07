import 'package:flutter/material.dart';
import 'package:introducing_flutter/model/Record.dart';
import 'package:introducing_flutter/model/RecordList.dart';
import 'model/RecordService.dart';
import 'helpers/Constants.dart';
import 'DetailPage.dart';
import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = new TextEditingController();

  RecordList records = new RecordList();
  RecordList filteredRecords = new RecordList();

  String _searchText = "";

  Icon _searchIcon = new Icon(Icons.search);
  Icon _logoutIcon = new Icon(Icons.exit_to_app);

  Widget _appBarTitle = new Text(appTitle);

  @override
  void initState() {
    super.initState();

    records.records = new List();
    filteredRecords.records = new List();

    _getRecords();
  }

  Future checkIsLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this.records.records.add(record);
        this.filteredRecords.records.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: <Widget>[
        new IconButton(icon: _logoutIcon, onPressed: _logoutPressed)
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      print("Searching...");
      filteredRecords.records = new List();
      print(records.records.length);
      for (int i = 0; i < records.records.length; i++) {
        print(records.records[i]);
        if (records.records[i].name.toLowerCase().contains(_searchText.toLowerCase())
            || records.records[i].address.toLowerCase().contains(_searchText.toLowerCase())) {
          filteredRecords.records.add(records.records[i]);
          print("Found!");
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this.filteredRecords.records.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                tag: "avatar_" + record.name,
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(record.photo),
                )
              )
            ),
            title: Text(
              record.name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                new Flexible(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: record.address,
                              style: TextStyle(color: Colors.white),
                            ),
                            maxLines: 3,
                            softWrap: true,
                          )
                        ]))
              ],
            ),
            trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));

              },
        ),
      ),
    );
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _logoutPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              fillColor: Colors.white,
              hintText: 'Search by name',
              hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(appTitle);
        _filter.clear();
      }
    });
  }

  void _resetRecords() {
    this.filteredRecords.records = new List();
    for (Record record in records.records) {
      this.filteredRecords.records.add(record);
    }
  }
}