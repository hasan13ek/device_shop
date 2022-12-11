import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/view_models/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  String categoryName = "";
  String descirpition = "";
  String dateTime = DateTime.now().toString();
  String imgUrl =
      "https://freepngimg.com/thumb/refrigerator/5-2-refrigerator-png-picture-thumb.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add Category"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
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
                controller: descController,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                onChanged: (val) {
                  descirpition = val;
                },
                validator: (val) {
                  if(val == null || val.isEmpty){
                    return "6 tadan kop kiriting";

                  }


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
                    print(categoryName);
                    print(descirpition);
                    print(imgUrl);
                    print(dateTime);
                        if(formKey.currentState!.validate()){
                          CategoryModel categoryModel = CategoryModel(
                              categoryId: "",
                              categoryName: categoryName,
                              description: descirpition,
                              imageUrl: imgUrl,
                              createdAt: dateTime);
                          Provider.of<CategoriesViewModel>(context, listen: false)
                              .addCategory(categoryModel);

                        }


                  },
                  child: const Text(
                    "Kategoriyani qo'shish",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }
}
