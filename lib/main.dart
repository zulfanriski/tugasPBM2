import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: getApi(),
    debugShowCheckedModeBanner: false,
  ));
}

class getApi extends StatefulWidget {
  const getApi({Key? key}) : super(key: key);

  @override
  State<getApi> createState() => _getApiState();
}

class _getApiState extends State<getApi> {
  final Uri url = Uri.parse("https://reqres.in/api/users?per_page=15");

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(url);
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GETTING API BY GROUP 1'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(), // Tambahkan Divider di antara setiap ListTile
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data[index]['avatar']),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.black),
                    ),
                    title: Text(snapshot.data[index]['first_name'] +
                        " " +
                        snapshot.data[index]['last_name']),
                    subtitle: Text(snapshot.data[index]['email']),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
