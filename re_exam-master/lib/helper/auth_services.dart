import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/home_model.dart';
import 'database_helper.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DBHelper _dbHelper = DBHelper();

  Future<void> signUpWithEmail(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> uploadItemsToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final items = await _dbHelper.getItems();

    for (var item in items) {
      await firestore.collection('shopping_list').doc(item.id.toString()).set(item.toMap());
    }
  }

  Future<void> fetchItemsFromFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('shopping_list').get();

    for (var doc in snapshot.docs) {
      ShoppingItem item = ShoppingItem(
        id: int.tryParse(doc.id),
        name: doc.data()['name'],
        quantity: doc.data()['quantity'],
        category: doc.data()['category'],
        purchased: doc.data()['purchased'] == 1,
      );

      await _dbHelper.insertItem(item);
    }
  }
}
