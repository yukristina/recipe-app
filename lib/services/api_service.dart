import 'dart:convert';
import 'dart:io';
import 'package:flutter_recipe/models/meal_plan_model.dart';
import 'package:flutter_recipe/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY = 'API_KEY';

  Future<MealPlan> generateMealPlan(
      {required int targetCalories, required String diet}) async {
    if (diet == 'None') diet = '';

    Map<String, dynamic> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY
    };

    Uri uri = Uri.http(_baseUrl, 'recipes/mealplans/generate', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = jsonDecode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, dynamic> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.http(_baseUrl, 'recipes/mealplans/generate', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = jsonDecode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    } catch (e) {
      throw e.toString();
    }
  }
}
