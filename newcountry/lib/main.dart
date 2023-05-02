import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Information',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Country Information  '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String desc = "No Data";
  TextEditingController countryInformationController = TextEditingController();
  String flagImageUrl = "";
  String countryCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Country Information 🌏 ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: countryInformationController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo, width: 4.0),
                ),
                hintText: 'Enter country name',
              ),
            ),
            ElevatedButton(
                onPressed: _getCountryInfo,
                child: const Text("Search Country Information")),
            if (flagImageUrl != "") ...[
              Image.network('https://flagsapi.com/$countryCode/shiny/64.png'),
            ],
            Text(desc,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Future<void> _getCountryInfo() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    String country = (countryInformationController.text);
    var url = Uri.parse('https://api.api-ninjas.com/v1/country?name=$country');
    var response = await http.get(url,
        headers: {'x-api-key': '6qaIdGUwar+Wyj1o14JYUA==Lx86nhQgVNRuWc9u'});

    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);

      setState(() {
        countryCode = parsedJson[0]['iso2'];
        flagImageUrl = 'https://flagsapi.com/$countryCode/flat/64.png';
      });

      setState(() {
        var name = parsedJson[0]['name'];
        var cap = parsedJson[0]['capital'];

        var curr = parsedJson[0]['currency']['code'];
        var iso = parsedJson[0]['iso2'];
        desc =
            "Country: $name \nCapital: $cap \nCurrency:  $curr  \nISO code: $iso";

        //END DIALOG THING
        progressDialog.dismiss();

        //TAMBAH TOAST
        Fluttertoast.showToast(
            msg: "Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            fontSize: 20.0);
      });
    } else {
      setState(() {
        desc = "No record found";
      });
    }
  }
}
      
     
//KEY:    
//6qaIdGUwar+Wyj1o14JYUA==Lx86nhQgVNRuWc9u