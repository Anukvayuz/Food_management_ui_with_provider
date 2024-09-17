import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app_with_provider/Files/Model/search_model.dart';
import 'package:food_app_with_provider/Files/base_api/base_api.dart';
import 'package:food_app_with_provider/Files/Model/meal_model.dart';

class MealProvider extends ChangeNotifier {
  API api = API();
  List<Meals> post = [];
  List<SearchResult> searchResult = [];
  bool isLoading = true;

  Future<void> fetchPosts() async {
    try {
      Response response = await api.sendrequest.get("/filter.php?a=Indian");

      if (response.statusCode == 200) {
        post = (response.data['meals'] as List)
            .map((data) => Meals.fromJson(data))
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

  // Fetch search items
  Future<void> fetchSearchItems(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      Response response = await api.sendrequest.get("/search.php?s=$query");

      if (response.statusCode == 200) {
        searchResult = (response.data['meals'] as List)
            .map((data) => SearchResult.fromJson(data))
            .toList();
        log("search results: $searchResult");
        
      } else {
        throw Exception('Failed to load search data');
      }
    } catch (e) {
      log('Error occurred: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
