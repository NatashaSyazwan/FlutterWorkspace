import 'dart:convert';

import 'package:barter_it/screens/purchaseitemscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:barter_it/models/item.dart';
import 'package:barter_it/models/user.dart';
import 'package:barter_it/myconfig.dart';
import 'package:http/http.dart' as http;

class BuyerDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  const BuyerDetailsScreen(
      {super.key, required this.useritem, required this.user});

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
  }

  final df = DateFormat('dd-MM-yyyy hh:mm a');

  late double screenHeight, screenWidth, cardwitdh;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: Column(children: [
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Card(
              child: PageView.builder(
                itemCount: 3, // Assuming you have 3 images
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth,
                    child: CachedNetworkImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${MyConfig().server}/barter_it/assets/images/${widget.useritem.itemId}_${index + 1}.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.useritem.itemName.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(6),
              },
              children: [
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemDesc.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Item Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemType.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Quantity Available",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemQty.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${widget.useritem.itemLocality}/${widget.useritem.itemState}",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      df.format(
                          DateTime.parse(widget.useritem.itemDate.toString())),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                onPressed: () {
                  if (userqty <= 1) {
                    userqty = 1;
                    totalprice = singleprice * userqty;
                  } else {
                    userqty = userqty - 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.remove)),
            Text(
              userqty.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  if (userqty >= qty) {
                    userqty = qty;
                    totalprice = singleprice * userqty;
                  } else {
                    userqty = userqty + 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.add)),
          ]),
        ),
        Text(
          "RM ${totalprice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.user.id.toString() ==
                widget.useritem.userId.toString()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User cannot add own item")));
              return;
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchaseItemScreen(
                    itemName: widget.useritem.itemName.toString(),
                    itemPrice: totalprice,

                    itemQuantity: userqty,
                    //totalPrice:double.parse(widget.useritem.totalPrice.toString()),
                  ),
                ),
              );
            }
          },
          child: Text('BUY'),
        ),
      ]),
    );
  }

  void addtocartdialog() {
    if (widget.user.id.toString() == widget.useritem.userId.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User cannot add own item")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Buy item?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                addtocart();
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

//`cart_id`, `item_id`, `cart_qty`, `cart_price`, `user_id`, `buyer_id`, `cart_date`
  void addtocart() {
    http.post(Uri.parse("${MyConfig().server}/barter_it/php/addtocart.php"),
        body: {
          "item_id": widget.useritem.itemId.toString(),
          "cart_qty": userqty.toString(),
          "cart_price": totalprice.toString(),
          "userid": widget.user.id,
          "sellerid": widget.useritem.userId
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.startsWith('success')) {
          responseBody = responseBody.substring(7);
        }
        var jsondata = jsonDecode(responseBody);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
        Navigator.pop(context);
      }
    });
  }
}
