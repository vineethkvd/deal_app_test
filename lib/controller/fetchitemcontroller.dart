import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FetchItemController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference banner =
      FirebaseFirestore.instance.collection('banner');
  final RxList<DocumentSnapshot> items = <DocumentSnapshot>[].obs;
  final RxList<DocumentSnapshot> banners = <DocumentSnapshot>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final snapshot = await products.orderBy('id').get();
    items.assignAll(snapshot.docs);
    final bannerSnapshot = await products.orderBy('id').get();
    items.assignAll(bannerSnapshot.docs);
  }
}
