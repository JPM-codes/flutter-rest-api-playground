import 'package:flutter/material.dart';

import 'package:rest_api_playground/src/pages/model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();

  final ProductModel product;
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: ListView(
        children: [
          Image.network(
            widget.product.images.first,
            height: sizeOf.height * 0.4,
            width: double.maxFinite,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text(
              widget.product.title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            leading: Icon(Icons.details),
            title: Text(widget.product.description),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('\$${widget.product.price.toStringAsFixed(2)}'),
          ),
          ListTile(
            leading: Icon(Icons.branding_watermark),
            title: Text('Brand: ${widget.product.brand}'),
          ),
        ],
      ),
    );
  }
}
