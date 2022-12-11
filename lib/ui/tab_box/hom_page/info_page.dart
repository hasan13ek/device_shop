import 'package:device_shop/data/models/order_model.dart';
import 'package:device_shop/data/models/product_model.dart';
import 'package:device_shop/ui/tab_box/card/card_page.dart';
import 'package:device_shop/utils/my_utils.dart';
import 'package:device_shop/view_models/orders_veiw_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key,required this.productModel}) : super(key: key);
final ProductModel productModel;

  @override
  State<InfoPage> createState() => _InfoPageState();
}
int opshe = 1;
class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Info page"),
      ),
      body: SizedBox(
        width:double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Card(
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text("Mahsulot nomi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.productModel.productName,style:const TextStyle(fontSize: 18),),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               const Expanded(child:  Text("Mahsulot narxi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
                  Text(widget.productModel.price.toString(),style:const TextStyle(fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.productModel.currency.toString(),style:const TextStyle(fontSize: 18),),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  const  Center(child:  Text("Mahsulot haqida ma'lumot",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
                 const SizedBox(height: 10,),
                  Text(widget.productModel.description.toString(),style:const TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            Card(
              color: Colors.lightBlueAccent,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text("Mahsulot soni",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                    ),
                    Container(
                      width: 115,
                      height: 35,
                      decoration: BoxDecoration(color: const Color(0xFFF2F4FF),borderRadius: BorderRadius.circular(60)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 35,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xFFDFE3FF)),
                            child: TextButton(onPressed: (){setState(() {
                              if(opshe>1){
                                opshe--;
                              }
                            });}, child: const Center(child: Text("-",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),))),),

                          Text("${opshe}",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 26),),

                          Container(width: 35,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color(0xFFA0ABFF)),
                            child: TextButton(onPressed: (){setState(() {
                              opshe++;
                            });}, child: const Center(child: Text("+",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),))),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics:const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: widget.productModel.productImages.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 6,left: 4,right: 4,bottom: 6),
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey),
                        borderRadius:
                        BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration:  BoxDecoration(
                            borderRadius:const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            image: DecorationImage(image:
                            NetworkImage(
                                widget.productModel.productImages[index]),
                                fit: BoxFit.fill,scale: 6),
                          ),
                        )
                      ],),
                  );
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    primary: Colors.lightBlueAccent,
                    elevation: 0),
                onPressed: () {
                  OrderModel orderModel = OrderModel(count: opshe, totalPrice: widget.productModel.price*opshe, orderId: "", productId: widget.productModel.productId, userId: FirebaseAuth.instance.currentUser!.uid, orderStatus: "order status bu", createdAt: DateTime.now().toString(), productName: widget.productModel.productName,);
                  Provider.of<OrderViewModel>(context,listen: false).addOrder(orderModel: orderModel);
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=>CardPage()));
                  // MyUtils.getMyToast(message: "Savatga qo'shildi");
                  opshe =0;
                },
                child: const Text(
                  "Savatga qo'shish",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),



          ],
        ),
      ),
    );
  }
}
