// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/products.dart';
import 'providers/cart.dart';
import 'providers/order.dart';
import 'providers/auth.dart';

// Screens
import 'screens/product_overview_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/user_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (_) => Products(),
          ),
          ChangeNotifierProvider(
            create: (_) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (_) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
