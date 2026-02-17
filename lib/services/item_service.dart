import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemService {
  // Versión del parche (puedes actualizarla según necesites)
  static const String version = '12.6.1';
  static const String baseUrl = 'https://ddragon.leagueoflegends.com/cdn';

  // Obtener todos los items
  Future<Map<String, Item>> getAllItems() async {
    final url = '$baseUrl/$version/data/en_US/item.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final itemsData = jsonData['data'] as Map<String, dynamic>;

        Map<String, Item> items = {};

        itemsData.forEach((key, value) {
          items[key] = Item.fromJson(key, value);
        });

        return items;
      } else {
        throw Exception('Error al cargar items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener un item específico por ID
  Future<Item?> getItemById(String itemId) async {
    final items = await getAllItems();
    return items[itemId];
  }
}
