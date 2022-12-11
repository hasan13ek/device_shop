import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/data/repositories/categories_repository.dart';

class CategoriesViewModel  {
  final CategoryRepository categoryRepository;

  CategoriesViewModel({required this.categoryRepository});

  Stream<List<CategoryModel>> listenCategories()=> categoryRepository.getCategories();

  addCategory(CategoryModel categoryModel)=> categoryRepository.addCategory(categoryModel: categoryModel);

  deleteCategory(String docId)=> categoryRepository.deleteCategory(docId: docId);

  updateCategory(CategoryModel categoryModel)=> categoryRepository.updateCategory(categoryModel: categoryModel);


}