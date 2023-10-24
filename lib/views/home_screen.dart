import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  ];

  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  List<DocumentSnapshot> items = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    QuerySnapshot snapshot = await products.orderBy('id').get();
    setState(() {
      items = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            // padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
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
                                setState(() {
                                  currentIndex = index;
                                });
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
                  bottom: 0,
                  child: Container(
                      child: GridView.builder(
                    shrinkWrap: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot productSnap = items[index];
                      return Card(
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              '${productSnap['image']}',
                              fit: BoxFit.cover,
                              height: 150, // Adjust image height as needed
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${productSnap['name']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
                          ],
                        ),
                      );
                    },
                  )))
            ]),
          ),
        ),
      ),
    );
  }
}
