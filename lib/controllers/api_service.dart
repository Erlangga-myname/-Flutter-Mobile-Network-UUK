import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Recipe>> getRecipes() async {
    try {
      print('Fetching recipes from: $baseUrl/recipes');  
      final response = await http.get(Uri.parse('$baseUrl/recipes'));
      
      print('Status code: ${response.statusCode}');  
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');  
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> recipes = data['recipes'] as List;
        return recipes.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipes: $e');  
      throw Exception('Error fetching recipes: $e');
    }
  }

  Future<Recipe> getRecipeById(int id) async {
    try {
      print('Fetching recipe details for id: $id'); 
      final response = await http.get(Uri.parse('$baseUrl/recipes/$id'));
      
      print('Status code: ${response.statusCode}'); 
      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); 
        final Map<String, dynamic> data = json.decode(response.body);
        return Recipe.fromJson(data);
      } else {
        throw Exception('Failed to load recipe details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipe details: $e'); 
      throw Exception('Error fetching recipe details: $e');
    }
  }
}