import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_recipe/models/meal_model.dart';
import 'package:flutter_recipe/models/meal_plan_model.dart';
import 'package:flutter_recipe/models/recipe_model.dart';
import 'package:flutter_recipe/screens/recipe_screen.dart';
import 'package:flutter_recipe/services/api_service.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key, required this.mealPlan});

  final MealPlan mealPlan;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total Nutrients',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.mealPlan.fat.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carbs: ${widget.mealPlan.carbs.toString()} g',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);
    return GestureDetector(
      onTap: () async {
        Recipe recipe =
            await APIService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RecipeScreen(mealType: mealType, recipe: recipe)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(meal.imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.all(60),
            padding: const EdgeInsets.all(60),
            color: Colors.white70,
            child: Column(
              children: [
                Text(
                  mealType,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                Text(
                  meal.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Meal Plan'),
      ),
      body: ListView.builder(
          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
}
