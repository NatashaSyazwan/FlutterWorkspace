import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barter_it/myconfig.dart';

class PurchaseItemScreen extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final int itemQuantity;
  //final double totalPrice;

  PurchaseItemScreen({
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
    //required this.totalPrice,
  });

  Future<void> confirmPurchase(BuildContext context) async {
    try {
      final Map<String, String> requestBody = {
        'item_id': '<ITEM_ID>', // Replace <ITEM_ID> with the actual item ID
        'user_id': '<USER_ID>', // Replace <USER_ID> with the actual user ID
      };

      final Uri uri =
          Uri.parse("${MyConfig().server}/barter_it/php/item_purchase.php");
      final http.Response response = await http.post(
        uri,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Purchase was successful
        // You can navigate to the NewTabScreen or show a success message
        Navigator.pushReplacementNamed(context, '/newtabscreen');
      } else {
        // Purchase failed
        // Show an error message or handle the error appropriately
      }
    } catch (error) {
      // Handle any exceptions or errors that occur during the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Item'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100], // Light purple background color
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the content vertically
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the content horizontally
                  children: [
                    Text(
                      'Item Name: $itemName',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Item Price: $itemPrice',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Item Quantity: $itemQuantity',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        confirmPurchase(
                            context); // Call the confirmPurchase method
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
