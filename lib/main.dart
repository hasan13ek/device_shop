import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_shop/data/repositories/auth_repositroy.dart';
import 'package:device_shop/data/repositories/categories_repository.dart';
import 'package:device_shop/data/repositories/order_repository.dart';
import 'package:device_shop/data/repositories/product_repository.dart';
import 'package:device_shop/ui/auth/auth_page.dart';
import 'package:device_shop/ui/tab_box/tab_box.dart';
import 'package:device_shop/view_models/auth_view_model.dart';
import 'package:device_shop/view_models/categories_view_model.dart';
import 'package:device_shop/view_models/orders_veiw_model.dart';
import 'package:device_shop/view_models/products_view_model.dart';
import 'package:device_shop/view_models/tab_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context)=>OrderViewModel(orderRepository: OrderRepository(firebaseFirestore: fireStore))),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(
            productRepository: ProductRepository(
              firebaseFirestore: fireStore,
            ),
          ),
        ),
        Provider(
          create: (context) => CategoriesViewModel(
            categoryRepository: CategoryRepository(
              firebaseFirestore: fireStore,
            ),
          ),
        ),
        ChangeNotifierProvider(create: (context) => TabViewModel()),
        Provider(
            create: (context) => AuthViewModel(
                authRepository:
                    AuthRepository(firebaseAuth: FirebaseAuth.instance)))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return TabBox();
          } else {
            return AuthPage();
          }
        });
  }
}
