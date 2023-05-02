/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'COUNTRY INFORMATION APP'),
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
  
  

  @override
  
   
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: Scaffold(
        appBar: EasySearchBar(
          title: const Text('Example'),
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () => Navigator.pop(context)
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () => Navigator.pop(context)
              )
            ]
          )
        ),
        body: Center(
          child: Text('Value: $searchValue')
        )
      )
    );
  }
}

  Future<void> _getCountry() async {
    var apiKey = '6qaIdGUwar+Wyj1o14JYUA==Lx86nhQgVNRuWc9u';
    Uri url = Uri.parse('https://api.api-ninjas.com/v1/country');
    final Map<String, String> headers = {'X-Api-Key': apiKey};

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode} ${response.body}');
    }
  }

*/

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchValue = '';
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  String desc = "No Data";
  TextEditingController countryInformationController = TextEditingController();
  String flagImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'COUNTRY INFORMATION',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: Scaffold(
            appBar: EasySearchBar(
                title: const Text('COUNTRY INFORMATION'),
                onSearch: (value) => setState(() => searchValue = value),
                suggestions: _suggestions),
            drawer: Drawer(
                child: ListView(padding: EdgeInsets.zero, children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                  title: const Text('Item 1'),
                  onTap: () => Navigator.pop(context)),
              ListTile(
                  title: const Text('Item 2'),
                  onTap: () => Navigator.pop(context))
            ])),
            body: Center(child: Text('Value: $searchValue'))));
  }

  Future<void> _getCountryInfo() async {
    String country = (countryInformationController.text);
    var url = Uri.parse('https://api.api-ninjas.com/v1/country?name=$country');
    var response = await http.get(url,
        headers: {'x-api-key': 'nMl0bkymQA1srihi5JIXPBUIJyEibMCcMkzOpsHo'});
    //var responses = await http.put(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      print(parsedJson);

      var countryCode = parsedJson[0]['iso2'];
      var flagImageUrl = 'https://flagsapi.com/$countryCode/flat/64.png';
      //var url2 = Uri.parse(
      // 'https://flagsapi.com/BE/flat/64.png');
      var response2 = await http.get(Uri.parse(flagImageUrl));
      //var responses2 = await http.put(url2);
      var rescode2 = response2.statusCode;
      if (rescode2 == 200) {
        /*var retrievedjson = response2.body;
          var json2 = json.decode(retrievedjson);
          flagImageUrl = json2[0]['flag_image'];*/
        setState(() {
          //flagImageUrl = json2[0]['flag_image'];
          flagImageUrl = flagImageUrl;
          print(flagImageUrl);
        });
      } else {
        throw Exception('Failed to load flag image');
      }

      setState(() {
        var gdp = parsedJson[0]['gdp'];
        var sexR = parsedJson[0]['sex_ratio'];
        var sur = parsedJson[0]['surface_area'];
        desc =
            "The gdp is $gdp. The sex ratio is $sexR and surface area is $sur km^2. ";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}
