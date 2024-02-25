import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/cart_item.dart';

class ArticleProvider extends ChangeNotifier {
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('article');

  Future<void> removeFromCart(String documentKey) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('article')
          .where('description', isEqualTo: documentKey)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        print('Item removed from Firebase successfully');
      } else {
        print('No items found with the provided description');
      }
    } catch (error) {
      print('Error removing item from Firebase: $error');
      // Handle the error as per your requirement
    }
  }

  Future<void> addToCart(ArticleItem item) async {
    try {
      await cartCollection.add({
        'image': item.image,
        'title': item.title,
        'description': item.description,
      });
      print('Item added to cart successfully');
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<List<ArticleItem>> getCartItems() async {
    try {
      QuerySnapshot querySnapshot = await cartCollection.get();
      List<ArticleItem> cartItems = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ArticleItem(
          image: data['image'],
          title: data['title'],
          description: data['description'],
        );
      }).toList();
      return cartItems;
    } catch (e) {
      print('Error retrieving cart items: $e');
      return [];
    }
  }
}
