import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/view_models/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({Key? key, required this.categoryModel})
      : super(key: key);

  final CategoryModel categoryModel;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  String categoryName = "";
  String descirpition = "";
  String imgUrl =
      "https://freepngimg.com/thumb/refrigerator/5-2-refrigerator-png-picture-thumb.png";

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(" Update Category"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: formKey,
              controller: nameController,
              // initialValue: widget.categoryModel.categoryName,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              onChanged: (val) {
                categoryName = val;
              },
              validator: (val) {
                if(val == null || val.length<6){
                  return "6 tadan kop kiriting";

                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(16)),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Mahsulot nomini Kiriting',
                focusColor: const Color(0xff868686),
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: formKey1,
              controller: descController,
              // initialValue: widget.categoryModel.description,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              onChanged: (val) {
                descirpition = val;
              },
              validator: (val) {
                if(val == null || val.length<6){
                  return "6 tadan kop kiriting";

                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(16)),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Mahsulot haqida malumot Kiriting',
                focusColor: const Color(0xff868686),
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    primary: Colors.lightBlueAccent,
                    elevation: 0),
                onPressed: () {},
                child: const Text(
                  "Rasmni Tanlang",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    primary: Colors.lightBlueAccent,
                    elevation: 0),
                onPressed: () {
                  CategoryModel categoryModel = CategoryModel(
                      categoryId: widget.categoryModel.categoryId,
                      categoryName: categoryName,
                      description: descirpition,
                      imageUrl: imgUrl,
                      createdAt: widget.categoryModel.createdAt);
                  Provider.of<CategoriesViewModel>(context, listen: false)
                      .updateCategory(categoryModel);


                },
                child: const Text(
                  "Kategoriyani yangilash",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
 
}