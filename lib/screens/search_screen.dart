import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_recipe/models/meal_plan_model.dart';
import 'package:flutter_recipe/screens/meals_screen.dart';
import 'package:flutter_recipe/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _diets = const [
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegeterian',
    'Ovo-Vegeterian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30'
  ];

  double _targetCalories = 2250;
  String _diet = 'None';

  void _searchMealPlan() async {
    MealPlan mealPlan = await APIService.instance
        .generateMealPlan(targetCalories: _targetCalories.toInt(), diet: _diet);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealScreen(mealPlan: mealPlan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://plus.unsplash.com/premium_photo-1670895801186-588af8aeef1c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Daily Meal Planner',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 25),
                        children: [
                      TextSpan(
                          text: _targetCalories.truncate().toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: ' cal',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ])),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Theme.of(context).primaryColor,
                      activeTickMarkColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Colors.lightBlue[100],
                      trackHeight: 6,
                    ),
                    child: Slider(
                      min: 0,
                      max: 4500,
                      value: _targetCalories,
                      onChanged: (value) {
                        setState(() {
                          _targetCalories = value.round().toDouble();
                        });
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField(
                    items: _diets.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        labelText: 'Diet',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        )),
                    onChanged: (value) {
                      setState(() {
                        _diet = value!;
                      });
                    },
                    value: _diet,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: _searchMealPlan,
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
