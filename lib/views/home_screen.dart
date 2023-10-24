import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/fetchitemcontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  ];

  final FetchItemController controller = Get.put(FetchItemController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() {
            var currentIndex = controller.currentIndex.value;
            return Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(children: [
                Positioned(
                  top: 5,
                  left: 10,
                  right: 10,
                  bottom: 20,
                  child: Container(
                    height: 20,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(-0.96, 0),
                          child: Text("Trending deals",
                              style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF3C3268),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            print(currentIndex);
                          },
                          child: Container(
                            child: CarouselSlider(
                              items: imgList.map((item) {
                                return Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(item,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 500),
                                    ),
                                  ),
                                );
                              }).toList(),
                              carouselController: carouselController,
                              options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 2.0,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  currentIndex = index;
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currentIndex == entry.key ? 17 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? Colors.red
                                      : Colors.teal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  left: 20,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    // color: Colors.red,
                    child: Text("All deals",
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color(0xFF3C3268),
                        )),
                  ),
                ),
                Positioned(
                    left: 10,
                    right: 10,
                    top: 280,
                    bottom: 160,
                    child: Container(
                        child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .60,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 10,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot productSnap =
                            controller.items[index];
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      '${productSnap['image']}',
                                      width: double.infinity,
                                    )),
                              ),
                              Text(
                                '${productSnap['name']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${productSnap['brand']}',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '₹ ${productSnap['price']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.add_shopping_cart),
                                      onPressed: () {
                                        final DocumentSnapshot selectedProduct =
                                            controller.items[index];
                                        controller.addToCart(selectedProduct);
                                      })
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )))
              ]),
            );
          }),
        ),
      ),
    );
  }
}
