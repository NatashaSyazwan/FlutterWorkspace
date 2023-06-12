import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:barter_it/models/item.dart';
import 'package:barter_it/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:barter_it/myconfig.dart';
import 'edititemscreen.dart';
import 'newitemscreen.dart';

class SellerTabScreen extends StatefulWidget {
  final User user;

  const SellerTabScreen({super.key, required this.user});

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Seller";
  List<Item> itemList = <Item>[];

  @override
  void initState() {
    super.initState();
    loadsellerItems();
    print("Seller");
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
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: RefreshIndicator(
        onRefresh: loadsellerItems,
        child: itemList.isEmpty
            ? const Center(
                child: Text("No Data"),
              )
            : Column(
                children: [
                  Container(
                    height: 24,
                    color: Theme.of(context).colorScheme.primary,
                    alignment: Alignment.center,
                    child: Text(
                      "${itemList.length} Items Found",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          itemList.length,
                          (index) {
                            return Card(
                              child: InkWell(
                                onLongPress: () {
                                  onDeleteDialog(index);
                                },
                                onTap: () async {
                                  Item singleitem =
                                      Item.fromJson(itemList[index].toJson());
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (content) => EditItemScreen(
                                        user: widget.user,
                                        useritem: singleitem,
                                      ),
                                    ),
                                  );
                                  loadsellerItems();
                                },
                                child: Column(
                                  children: [
                                    for (int i = 1; i <= 3; i++)
                                      CachedNetworkImage(
                                        width: screenWidth,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "${MyConfig().server}/barter_it/assets/images/${itemList[index].itemId}_$i.png",
                                        placeholder: (context, url) =>
                                            const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    Text(
                                      itemList[index].itemName.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "${itemList[index].itemQty} available",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (widget.user.id != "na") {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => NewItemScreen(
                            user: widget.user,
                          )));
              loadsellerItems();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
          )),
    );
  }

  Future<void> loadsellerItems() async {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().server}/barter_it/php/load_items.php"),
        body: {"userid": widget.user.id}).then((response) {
      //print(response.body);
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }

  void onDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete ${itemList[index].itemName}?",
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                deleteItem(index);
                Navigator.of(context).pop();
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

  void deleteItem(int index) {
    http.post(Uri.parse("${MyConfig().server}/barter_it/php/delete_item.php"),
        body: {
          "userid": widget.user.id,
          "itemid": itemList[index].itemId
        }).then((response) {
      print(response.body);
      //itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadsellerItems();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
      }
    });
  }
}






















/*import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:barter_it/models/item.dart';
import 'package:barter_it/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:barter_it/myconfig.dart';
//import 'newitemscreen.dart';

class SellerTabScreen extends StatefulWidget {
  final User user;

  const SellerTabScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  
  String maintitle = "Seller";
  List<Item> itemList = <Item>[];

  @override
  void initState() {
    super.initState();
    loadsellerItems();
    print("Seller");
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
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: itemList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(
              children: [
                Container(
                  height: 24,
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.center,
                  child: Text(
                    "${itemList.length} Items Found",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: axiscount,
                    children: List.generate(
                      itemList.length,
                      (index) {
                        return Card(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                width: screenWidth,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "${MyConfig().server}/barter_it/assets/items/${itemList[index].itemID}.png",
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Text(
                                itemList[index].itemName.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "${itemList[index].itemQty} available",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void loadsellerItems() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().server}/barter_it/php/load_items.php"),
        body: {"userid": widget.user.id}).then((response) {
      //print(response.body);
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }

        setState(() {});
      }
    });
  }
}
*/