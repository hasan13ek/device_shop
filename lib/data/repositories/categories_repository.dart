import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/utils/my_utils.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Stream<List<CategoryModel>> getCategories() => _firestore
      .collection("categories")
      .snapshots()
      .map((event1) => event1.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList());



  Future<void> addCategory({required CategoryModel categoryModel})async{
    try {
      DocumentReference newCategory = await  _firestore.collection("categories").add(categoryModel.toJson());
      await _firestore.collection("categories").doc(newCategory.id).update({"categoryId":newCategory.id});
      MyUtils.getMyToast(message: "Kategoriya muvaffaqiyatli qo'shildi");
    } on FirebaseException catch(error){
      MyUtils.getMyToast(message: error.message.toString());
    }
  }

  Future<void> deleteCategory ({required String docId})async{
    try{
      await _firestore.collection("categories").doc(docId).delete();
      MyUtils.getMyToast(message: "Kategoriya muvaffaqiyatli o'chirildi");
    } on FirebaseException catch(error){
      MyUtils.getMyToast(message: error.message.toString());
    }
  }


  Future<void> updateCategory({required CategoryModel categoryModel})async{
    try{
      await _firestore.collection("categories").doc(categoryModel.categoryId).update(categoryModel.toJson());
      MyUtils.getMyToast(message: "Kategoriya muvaffaqiyatli yangilandi");
    } on FirebaseException catch(error){
      MyUtils.getMyToast(message: error.message.toString());
    }
  }



}
