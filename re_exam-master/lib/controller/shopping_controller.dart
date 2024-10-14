import 'package:get/get.dart';
import '../helper/database_helper.dart';
import '../helper/firebase_helper.dart';
import '../model/home_model.dart';

class ShoppingController extends GetxController {
  final DBHelper dbHelper = DBHelper();
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  var items = <ShoppingItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchdata();
  }

  Future<void> fetchdata() async {
    final data = await dbHelper.getItems();
    items.assignAll(data);
  }

  Future<void> addItem(String name, int quantity, String category) async {
    final newItem = ShoppingItem(
      name: name,
      quantity: quantity,
      category: category,
      purchased: false,
    );
    await dbHelper.insertItem(newItem);
    fetchdata();
  }

  Future<void> deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    fetchdata();
  }

  Future<void> Purchased(
    int id,
    bool purchased,
  ) async {
    await dbHelper.updateItemPurchased(id, purchased);
    fetchdata();
  }

  Future<void> editItem(ShoppingItem updatedItem) async {
    await dbHelper.updateItem(updatedItem);
    fetchdata();
  }

  Future<void> Firebase() async {
    await _firebaseHelper.uploadFirestore(items);
    final Item = await _firebaseHelper.fetchItemsFromFirestore();
    await dbHelper.syncLocalDatabase(Item);
    fetchdata();
  }
}
