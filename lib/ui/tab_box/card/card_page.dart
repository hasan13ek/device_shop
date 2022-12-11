import 'package:device_shop/data/models/order_model.dart';
import 'package:device_shop/view_models/orders_veiw_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}
OrderModel? orders;
class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card"),
      ),
      body: 
             StreamBuilder<List<OrderModel>>(
            stream: Provider.of<OrderViewModel>(context,listen: false).listenOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                List<OrderModel> orderModel = snapshot.data!;
                return
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: List.generate(orderModel.length, (index) {
                            orders = orderModel[index];
                            return Card(
                              color: Colors.lightBlueAccent,
                              child: ListTile(
                                title: Text(orders!.productName),
                                trailing: SizedBox(
                                  width: 50,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Provider.of<OrderViewModel>(context,
                                                listen: false)
                                                .deleteOrder(docId: orders!.orderId,);

                                            print("DELETING ID:${orders!.orderId}");
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 7,
                                color: Colors.grey.shade300,
                                offset: const Offset(1, 4),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Umumiy summa  --->",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "\$ ${orders!.totalPrice}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff4047C1),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  );
              } else {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            },
        ),
    );
  }
}
