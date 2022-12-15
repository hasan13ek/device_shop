import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/data/models/product_model.dart';
import 'package:device_shop/utils/my_utils.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;




  Stream<List<ProductModel>> getProduct({required String categoryId}) async* {
    if (categoryId.isEmpty) {
      yield* _firestore.collection("products").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* _firestore
          .collection("products")
          .where("categoryId", isEqualTo: categoryId)
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }


}
