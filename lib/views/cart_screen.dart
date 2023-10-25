import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/fetchitemcontroller.dart';

class CartScreen extends StatefulWidget {
  final DocumentSnapshot? selectedProduct;

  CartScreen({this.selectedProduct, Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FetchItemController controller = Get.put(FetchItemController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.cartdatas.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot productSnap = controller.cartdatas[index];
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      offset: Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    '${productSnap['image']}',
                    width: 80,
                  ),
                ),
                Expanded(
                    child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 14),
                      child: Text(
                        '${productSnap['name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.chevron_left), onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${productSnap['price']}', // Display price with 2 decimal places
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.chevron_right), onPressed: () {}),
                      ],
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    '${productSnap['price']}', // Display price with 2 decimal places
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
