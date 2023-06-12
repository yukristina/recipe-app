import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/recipe_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key, required this.mealType, required this.recipe});

  final String mealType;
  final Recipe recipe;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealType),
      ),
      body: WebView(
        initialUrl: widget.recipe.spoonacularSourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
