import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barter_it/models/user.dart';
import 'package:barter_it/screens/loginscreen.dart';
import 'package:barter_it/screens/registrationscreen.dart';
import 'package:http/http.dart' as http;
import 'package:barter_it/myconfig.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    print("Profile");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      width: screenWidth * 0.4,
                      child: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Text(
                            widget.user.name.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(widget.user.email.toString()),
                          Text(widget.user.phone.toString()),
                          Text(widget.user.datereg.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.background,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                child: Text(
                  "PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (content) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink.shade300, // Set button color here
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (content) => const RegistrationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.deepPurple.shade400, // Set button color here
                    ),
                    child: const Text(
                      "REGISTRATION",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    /*if (widget.user.id.toString() == "na") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please register to view details.")),
                                  );
                                }*/

                    onPressed: () {
                      if (widget.user.id.toString() == "na") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please login first.")),
                        );
                      } else {
                        _updateNameDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink.shade300, // Set button color here
                    ),
                    child: const Text(
                      "CHANGE NAME",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.user.id.toString() == "na") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please login first.")),
                        );
                      } else {
                        _updatePhoneDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.deepPurple.shade400, // Set button color here
                    ),
                    child: const Text(
                      "CHANGE PHONE NUMBER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _changePassDialog,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink.shade300, // Set button color here
                    ),
                    child: const Text(
                      "UPDATE PASSWORD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//NEW START HERE, BAWAH SKALI ADA SATU  } ORIGINAL
  void _updateNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Name?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newname = _nameController.text;
                _updateName(newname);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateName(String newname) {
    http.post(
        Uri.parse("${MyConfig().server}/barter_it/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "newname": newname,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Name updated successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("NAME UPDATE FAILED")),
          );
        }
        Navigator.pop(context);
      }
    });
  }

  void _updatePhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Phone?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new your phone';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newphone = _phoneController.text;
                _updatePhone(newphone);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatePhone(String newphone) {
    http.post(
        Uri.parse("${MyConfig().server}/barter_it/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "newphone": newphone,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Phone number updated successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PHONE NUMBER UPDATE FAILED")),
          );
        }
        Navigator.pop(context);
      }
    });
  }

  void _changePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Password?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _oldpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Old Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _newpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                changePass();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changePass() {
    http.post(
        Uri.parse("${MyConfig().server}/barter_it/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "oldpass": _oldpasswordController.text,
          "newpass": _newpasswordController.text,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password updated successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PASSWORD UPDATE FAILED")),
          );
        }
        Navigator.pop(context);
      }
    });
  }
}
