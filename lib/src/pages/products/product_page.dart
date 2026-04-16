import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_playground/src/pages/model/product_model.dart';
import 'package:rest_api_playground/src/pages/products/product_detail_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.categoryUrl});

  @override
  State<ProductsPage> createState() => _ProductsPageState();

  final String categoryUrl;
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products Catalog')),
      body: FutureBuilder(
        future: get(Uri.parse(widget.categoryUrl)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erra ao consultar productos.'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Não existem produtos cadastrados'));
          }

          final json = jsonDecode(snapshot.data!.body);
          final products = json['products'] as List;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = ProductModel.fromJson(products[index]);
              return Card.outlined(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.thumbnail,),
                  ),
                  title: Text(products[index]['title']),
                  subtitle: Text(product.brand!),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
