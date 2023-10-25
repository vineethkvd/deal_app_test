import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FetchItemController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final CollectionReference products =
  FirebaseFirestore.instance.collection('products');
  final CollectionReference banner =
  FirebaseFirestore.instance.collection('banner');
  final CollectionReference cart =
  FirebaseFirestore.instance.collection('cartitems');
  final RxList<DocumentSnapshot> items = <DocumentSnapshot>[].obs;
  final RxList<DocumentSnapshot> cartItems = <DocumentSnapshot>[].obs;
  final RxList<DocumentSnapshot> banners = <DocumentSnapshot>[].obs;
  final RxList<dynamic> cartdatas = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    displayCartItems();
    displayProducts();
  }

  // Add a product to the cart
  Future<void> addProductToCart(DocumentSnapshot data) async {
    try {
      await cart.add(data.data());
      print("Added to cart");
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  // Display banners from Firestore
  Future<void> displayBanners() async {
    try {
      final snapshot = await banner.orderBy('id').get();
      banners.assignAll(snapshot.docs);
    } catch (e) {
      print("Error displaying banners: $e");
    }
  }

  // Display cart items from Firestore
  Future<void> displayCartItems() async {
    try {
      final snapshot = await cart.orderBy('id').get();
      cartItems.assignAll(snapshot.docs);
    } catch (e) {
      print("Error displaying cart items: $e");
    }
  }

  // Display products from Firestore
  Future<void> displayProducts() async {
    try {
      final snapshot = await products.orderBy('id').get();
      items.assignAll(snapshot.docs);
    } catch (e) {
      print("Error displaying products: $e");
    }
  }

  // Add a selected product to the cart data
  Future<void> addCartItem(DocumentSnapshot selectedProduct) async {
    try {
      cartdatas.add(selectedProduct);
      print(cartdatas);
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

}
