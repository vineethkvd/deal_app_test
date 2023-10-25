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
  @override
  void onInit() {
    super.onInit();
    displayCartItems();
    displayProducts();
  }
  Future<void> addToCart(DocumentSnapshot data) async {
    await cart.add(data.data());
    print("Added");
  }
  Future<void> displayBanners() async {
    final snapshot = await banner.orderBy('id').get();
    banners.assignAll(snapshot.docs);

  }
  Future<void> displayCartItems() async {
    final snapshot = await cart.orderBy('id').get();
    cartItems.assignAll(snapshot.docs);
  }

  Future<void> displayProducts() async {
    final snapshot = await products.orderBy('id').get();
    items.assignAll(snapshot.docs);
  }
}
