import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersPage extends StatefulWidget {
  
  UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {


  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList(){
    var showResults = [];
    if (_searchController.text != ""){
      for(var userSnapshot in _allResults){
        var fname = userSnapshot['fname'].toString().toLowerCase();
        var lname = userSnapshot['lname'].toString().toLowerCase();
        if(fname.contains(_searchController.text.toLowerCase()) || lname.contains(_searchController.text.toLowerCase())){
          showResults.add(userSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserStream();
  }
  
  List _allResults = [];
  List _resultsList = [];
  final TextEditingController _searchController = TextEditingController();

  getUserStream() async {
    var data = await FirebaseFirestore.instance.collection('Users').orderBy('fname').get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'USERS',
          style: TextStyle(color: Colors.white, letterSpacing: 3.0),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoTextField(
              controller: _searchController,
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ),
              placeholder: 'Search',
              onChanged: (val) {
                if(val.isNotEmpty) {
                  setState(() {
                    _allResults = _allResults.where((user) => user['fname'].toString().toLowerCase().contains(val.toLowerCase())).toList();
                  });
                } else {
                  getUserStream();
                }
              },
            )
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _resultsList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("${_resultsList[index]['fname'].toString().toUpperCase()} ${_resultsList[index]['lname'].toString().toUpperCase()}", style: const TextStyle(fontSize: 16, letterSpacing: 1.5,),),
              subtitle: Text(_resultsList[index]['email'], style: const TextStyle(fontSize: 14, letterSpacing: 1.0,),),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.white),
              )
            ),
          );
        }
      ),
    );
  }
}