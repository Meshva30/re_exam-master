import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/home_model.dart';

class FirebaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> uploadFirestore(List<ShoppingItem> items) async {
    try {
      final collection =  firestore.collection('shopping_items');
      for (var item in items) {
        await collection.doc(item.id.toString()).set(item.toMap());
      }
      print('Data uploaded successfully');
    } catch (e) {
      print('Error uploading data: $e');
    }
  }


  Future<List<ShoppingItem>> fetchItemsFromFirestore() async {
    final collection = firestore.collection('shopping_items');
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ShoppingItem.fromMap(data);
    }).toList();
  }
}
