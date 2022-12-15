import 'package:device_shop/data/models/order_model.dart';
import 'package:device_shop/view_models/orders_veiw_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Card"),
      ),
      body:
      Consumer<OrdersViewModel>(
        builder: (context, orderViewModel, child) {
          var totalPrice = orderViewModel.userOrders.isNotEmpty?orderViewModel.userOrders.map((e) => (e.totalPrice)).reduce((value, element) => value + element,):0;
          return
            Column(
              children:<Widget> [
                Expanded(
                  child: ListView(
                    children: List.generate(orderViewModel.userOrders.length, (index) {
                      var order = orderViewModel.userOrders[index];
                      return Card(
                        color: Colors.grey.withOpacity(0.4),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Nomi:   ${order.productName}",style: TextStyle(color: Colors.white),),
                            Text("soni:   ${order.count}",style: TextStyle(color: Colors.white),),
                          ],),
                          onTap: () {
                            orderViewModel.getSingleOrder(order.orderId);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (builder) => CardInfo()));
                          },
                          trailing: IconButton(
                              onPressed: () {
                                Provider.of<OrdersViewModel>(context,listen: false).deleteOrder(order.orderId);
                              },
                              icon: const Icon(Icons.delete,color: Colors.red,)),
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.4),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          spreadRadius: 7,
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(4, 4),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Umumiy summa  --->",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$ $totalPrice",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )

              ],
            );


        },
      ),
    );
  }
}

