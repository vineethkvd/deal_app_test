import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_app_test/views/cart_screen.dart';
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
'https://firebasestorage.googleapis.com/v0/b/dealapptestproject.appspot.com/o/banner%201.png?alt=media&token=7cfa1d0c-92db-4d68-b23f-89ebb4253b57&_gl=1*1yi2jmn*_ga*NzM2ODU1NTcxLjE2OTUwNDcwMzk.*_ga_CW55HF8NVT*MTY5ODIxNTQwOC45LjEuMTY5ODIxNTQ1NS4xMy4wLjA.',
    'https://firebasestorage.googleapis.com/v0/b/dealapptestproject.appspot.com/o/banner%202.png?alt=media&token=7c61cd53-608c-4606-9b8a-37730dd2b039&_gl=1*1ety3xf*_ga*NzM2ODU1NTcxLjE2OTUwNDcwMzk.*_ga_CW55HF8NVT*MTY5ODIxNTQwOC45LjEuMTY5ODIxNTQ4MS42MC4wLjA.',
    'https://firebasestorage.googleapis.com/v0/b/dealapptestproject.appspot.com/o/banner%203.png?alt=media&token=895d2d66-25a9-44a5-9428-6e952a99dff4&_gl=1*1g0rryh*_ga*NzM2ODU1NTcxLjE2OTUwNDcwMzk.*_ga_CW55HF8NVT*MTY5ODIxNTQwOC45LjEuMTY5ODIxNTU5MS42MC4wLjA.'
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
                  top: 280,
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
                    top: 300,
                    bottom: 160,
                    child: Container(
                        child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .58,
                        mainAxisSpacing: 10,
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
                                        final DocumentSnapshot selectedProduct = controller.items[index];
                                        controller.addCartItem(selectedProduct);
                                        print('$selectedProduct');
                                      }
                                  )
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
