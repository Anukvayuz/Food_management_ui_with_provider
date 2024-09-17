import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app_with_provider/Files/Model/meal_detail_model.dart';
import 'package:food_app_with_provider/Files/base_api/base_api.dart';

class MealDetailData extends ChangeNotifier {
  API api = new API();
  List<dynamic> mealDetails = [];

  bool isLoading = true;

  Future<void> fetchMealData(String id) async {
    try {
      Response responseData = await api.sendrequest.get("/lookup.php?i=$id");

      if (responseData.statusCode == 200) {
        mealDetails = (responseData.data['meals'] as List)
            .map((data) => MealDetail.fromJson(data))
            .toList();
      } else {
        throw Exception("Error fetching data");
      }
    } catch (ex) {
      throw ex;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
