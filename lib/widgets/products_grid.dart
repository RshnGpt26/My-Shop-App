// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/products.dart';

// Widgets
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[
            i], // create: (ctx) => products[i], // to write this alternative syntax => 1. remove 'value' key from above line, 2. remove .value ChangeNotifierProvider widget, 3. And now remove first '//' from this line - It will work. Note: => In main.dart we can use this syntax but in other widgets(like ProductsGrid, ...) this syntax is less efficient.
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
