// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/order.dart' show Orders;

// Widgets
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: FutureBuilder(
          future: _orderFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          },
        )
        //body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        //   itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        //   itemCount: orderData.orders.length,
        // ),
        );
  }
}
