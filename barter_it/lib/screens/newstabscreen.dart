import 'package:flutter/material.dart';
import 'package:barter_it/models/user.dart';

// for profile screen

class NewsTabScreen extends StatefulWidget {
  final User user;

  const NewsTabScreen({super.key, required this.user});

  @override
  State<NewsTabScreen> createState() => _NewsTabScreenState();
}

class _NewsTabScreenState extends State<NewsTabScreen> {
  String maintitle = "Items";

  @override
  void initState() {
    super.initState();
    print("Items");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Text(maintitle),
    );
  }
}
