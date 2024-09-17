import 'package:flutter/material.dart';
import 'package:food_app_with_provider/Files/Screen/detail_screen.dart';
import 'package:food_app_with_provider/Provider/meal_data.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<MealProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MealProvider>(
        builder: (BuildContext context, MealProvider mealProvider, child) {
          return ListView.builder(
            itemCount: mealProvider.searchResult.length,
            itemBuilder: (context, index) {
              var meal = mealProvider.searchResult[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          indx: meal.idMeal.toString(),
                        ), // Navigate to DetailScreen
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(meal.idMeal ?? 'No ID'),
                    subtitle: Text(meal.strMeal ?? 'No Meal Name'),
                    // leading: Container(
                    //   height: 100,
                    //   width: 100,
                    //   child: meal.strMealThumb != null
                    //       ? Image.network(meal.strMealThumb, fit: BoxFit.cover)
                    //       : const Icon(Icons.image_not_supported),
                    // ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
