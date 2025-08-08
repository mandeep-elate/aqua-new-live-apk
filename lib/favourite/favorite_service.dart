import 'dart:convert';
import 'package:aqaumatic_app/favourite/favourite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteService {
  final String _favouriteKey = 'favourite';

  // Get the cart from shared preferences
  Future<List<FavoriteItem>> getFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favouriteJson = prefs.getString(_favouriteKey);
    if (favouriteJson != null) {
      List<dynamic> favouriteData = jsonDecode(favouriteJson);
      return favouriteData.map((item) => FavoriteItem.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> addToFavourite(FavoriteItem item) async {
    final favourites = await getFavourite();
    final existingItemIndex = favourites.indexWhere((favouriteItem) => favouriteItem.id == item.id);

    if (existingItemIndex >= 0) {
      // If the item already exists, you might not need to add it again.
      // You can simply return if you're not allowing duplicates.
      return;  // Item already in favorites, no need to add it again
    } else {
      // Add new item to the favorites
      favourites.add(item);
    }

    // Save the updated list to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_favouriteKey, json.encode(favourites.map((item) => item.toJson()).toList()));
  }



  Future<void> updateCartItem(int id, int newQuantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];

    // Find the item in the local cart and update the quantity
    for (int i = 0; i < cartItems.length; i++) {
      final cartItem = jsonDecode(cartItems[i]);
      if (cartItem['id'] == id) {
        cartItem['quantity'] = newQuantity;
        cartItems[i] = jsonEncode(cartItem);
        break;
      }
    }

    // Save the updated cart back to shared preferences
    await prefs.setStringList('cartItems', cartItems);
  }

  Future<void> removeFromFavourite(int id) async {
    final favourites = await getFavourite();
    favourites.removeWhere((item) => item.id == id);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_favouriteKey, json.encode(favourites.map((item) => item.toJson()).toList()));
  }

}
