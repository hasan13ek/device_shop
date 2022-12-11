import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/data/models/product_model.dart';
import 'package:device_shop/ui/admin/category/add_category_screen.dart';
import 'package:device_shop/ui/admin/category/update_category_screen.dart';
import 'package:device_shop/ui/admin/product/add_product_screen.dart';
import 'package:device_shop/ui/admin/product/update_product_screen.dart';
import 'package:device_shop/view_models/categories_view_model.dart';
import 'package:device_shop/view_models/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Admin"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<ProductViewModel>(builder: (context,pro,child) {
        return ListView(
          children: List.generate(pro.productAdmin.length, (index) {
            var productModel = pro.productAdmin[index];
            return Card( color: Colors.lightBlueAccent,
              child: ListTile(
                title: Text(productModel.productName),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateProductScreen(productModel: productModel)));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Provider.of<ProductViewModel>(context,
                                listen: false)
                                .deleteProduct(productModel.productId);

                            print("DELETING ID:${productModel.productId}");
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
