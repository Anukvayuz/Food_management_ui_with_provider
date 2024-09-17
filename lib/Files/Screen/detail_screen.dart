import 'package:flutter/material.dart';
import 'package:food_app_with_provider/Provider/meal_detail.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String indx;
  DetailScreen({super.key, required this.indx});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<MealDetailData>(context as BuildContext, listen: false)
        .fetchMealData(widget.indx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Meal Detail Screen"),
      ),
      body: Consumer<MealDetailData>(
        builder:
            (BuildContext context, MealDetailData mealProviderdata, child) {
          if (mealProviderdata.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (mealProviderdata.mealDetails.isEmpty) {
            return const Center(child: Text("No meals available."));
          } else {
            return ListView.builder(
              itemCount: mealProviderdata.mealDetails.length,
              itemBuilder: (context, index) {
                var mealdata = mealProviderdata.mealDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(mealdata.idMeal ?? 'No ID'),
                      Image.network(mealdata.strMealThumb ?? "Image "),
                    ],
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
