import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_playground/src/pages/model/recipe_model.dart';
import 'package:rest_api_playground/src/pages/recipes/recipe_detail_page.dart';

class RecipeCatalogPage extends StatefulWidget {
  const RecipeCatalogPage({super.key, required this.categoryUrl, required this.title});

  @override
  State<RecipeCatalogPage> createState() => _RecipeCatalogPageState();

  final String categoryUrl;
  final String title;
}

class _RecipeCatalogPageState extends State<RecipeCatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} Catalog')),
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
          final recipes = json['recipes'] as List;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = RecipeModel.fromJson(recipes[index]);
              return Card.outlined(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(recipe.image),
                  ),
                  title: Text(recipe.name),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (context) => RecipeDetailPage(recipe: recipe),
                        ));
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
