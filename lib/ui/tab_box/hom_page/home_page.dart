import 'package:device_shop/data/models/category_model.dart';
import 'package:device_shop/ui/tab_box/hom_page/info_page.dart';
import 'package:device_shop/view_models/categories_view_model.dart';
import 'package:device_shop/view_models/color_is_on.dart';
import 'package:device_shop/view_models/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
int indexx = 0;


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Home"),
          actions: [
            IconButton(onPressed: (){
              Provider.of<ProductViewModel>(
                context,
                listen: false,
              ).listenProducts("");
            }, icon:const Text("ALL",style: TextStyle(fontSize: 18),))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              child: StreamBuilder<List<CategoryModel>>(
                stream: Provider.of<CategoriesViewModel>(context, listen: false)
                    .listenCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    List<CategoryModel> categories = snapshot.data!;
                    return Container(
                      height: 50,
                      padding: const EdgeInsets.all(2),
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                        return GestureDetector (
                          onTap: (){
                           indexx = index;
                            Provider.of<ProductViewModel>(
                              context,
                              listen: false,
                            ).listenProducts(categories[index].categoryId);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2,color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Center(child: Text(categories[index].categoryName,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white),)),
                              const  SizedBox(width: 6,),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(categories[index].imageUrl),fit: BoxFit.cover)),
                                )
                              ],
                            ),
                          ),
                        );
                      },

                      ),
                    );

                        // Provider.of<ProductViewModel>(
                        //   context,
                        //   listen: false,
                        // ).listenProducts("");



                  } else {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                },
              ),
            ),
            // SizedBox(height: 20,),
            Expanded(child:
            Consumer<ProductViewModel>(
              builder: (context, productViewModel, child) {
                return ListView(
                  children:
                      List.generate(productViewModel.products.length, (index) {
                    var product = productViewModel.products[index];
                    return Card(
                      color: Colors.grey.withOpacity(0.4),
                      child: ListTile(
                        title: Text(product.productName,style: TextStyle(color: Colors.white),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>InfoPage(productModel: product)));
                        },
                      ),
                    );
                  }),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
