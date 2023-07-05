import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Location',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CheckInScreen(),
    );
  }
}

class CheckInScreen extends StatefulWidget {
  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gpsController = TextEditingController();

  String gpsCoordinates = '';

  @override
  void initState() {
    super.initState();
    fetchGPS();
  }

  void fetchGPS() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        gpsCoordinates = '${position.latitude}, ${position.longitude}';
        gpsController.text = gpsCoordinates;
      });
    } catch (e) {
      print('Failed to get GPS coordinates: $e');
    }
  }

  void saveCheckIn(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String gps = gpsController.text;

    Map<String, String> data = {
      'name': name,
      'email': email,
      'gps': gps,
    };

    String jsonData = jsonEncode(data);
    print(jsonData);

    var response = await http.post(
      Uri.parse("http://192.168.234.210/save_checkin.php"),
      body: {
        'name': name,
        'email': email,
        'gpscoordinate': gps,
      },
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Check-in successful, display a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Check-In Successful'),
            content: Text('Your check-in has been saved.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Check-in failed, display an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Check-In Failed'),
            content: Text('Failed to save your check-in.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOCATOR 2 U',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Get your GPS location now!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: gpsController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'GPS Coordinates',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => saveCheckIn(context),
              child: const Text('Check In'),
            ),
          ],
        ),
      ),
    );
  }
}
