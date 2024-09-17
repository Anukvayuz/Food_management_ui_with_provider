import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app_with_provider/Files/Screen/detail_screen.dart';

import 'package:food_app_with_provider/Provider/meal_data.dart';
import 'package:food_app_with_provider/utils/app_strings.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<MealProvider>(context, listen: false).fetchPosts();
    //Provider.of<MealProvider>(context, listen: false).fetchSearchItems(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.amber,
        title: TextField(
          onChanged: (value) {
            Provider.of<MealProvider>(context, listen: false)
                .fetchSearchItems(value);
          },
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search meals...',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Call search function when search icon is pressed
                Provider.of<MealProvider>(context, listen: false)
                    .fetchSearchItems(_searchController.text);
              },
            ),
          ),
        ),
      ),
      body: Consumer<MealProvider>(
        builder: (BuildContext context, MealProvider mealProvider, child) {
          if (mealProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (mealProvider.searchResult.isEmpty) {
            log("lenght: ${mealProvider.searchResult.length}");
            return Center(child: Text(AppStrings.noMealsAvailable));
          } else {
            return ListView.builder(
              itemCount: mealProvider.searchResult.length,
              itemBuilder: (context, index) {
                var meal = mealProvider.searchResult[index];
                log("lenght: ${mealProvider.searchResult.length}");
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            indx: meal.idMeal.toString(),
                          ), // Navigate to Second page
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(meal.idMeal ?? 'No ID'),
                      subtitle: Text(meal.strMeal ?? 'No Meal Name'),
                      leading: Container(
                          height: 150,
                          width: 200,
                          child: Image.network(meal.strMealThumb ?? "Image ")),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
