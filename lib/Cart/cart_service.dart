import 'dart:convert';
import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final String _cartKey = 'cart';

  // Get the cart from shared preferences
  Future<List<CartItem>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      List<dynamic> cartData = jsonDecode(cartJson);
      return cartData.map((item) => CartItem.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();

    // Option 1: Set the cart to an empty list
    prefs.setString(_cartKey, json.encode([]));

    // Option 2: Remove the cart key entirely (choose either this or Option 1)
    // await prefs.remove(_cartKey);
  }


  Future<void> addToCart(CartItem item) async {
    final cart = await getCart();
    final existingItemIndex = cart.indexWhere((cartItem) => cartItem.id == item.id);

    if (existingItemIndex >= 0) {
      // Update quantity if the item already exists
      cart[existingItemIndex].quantity += item.quantity;
    } else {
      // Add new item to cart
      cart.add(item);
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cartKey, json.encode(cart.map((item) => item.toJson()).toList()));
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
  Future<void> incrementQuantity(int id) async {
    final cartItems = await getCart();
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      cartItems[index].quantity++;
      await updateCartInPrefs(cartItems);
    }
  }

  Future<void> decrementQuantity(int id) async {
    final cartItems = await getCart();
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      await updateCartInPrefs(cartItems);
    }
  }

  Future<void> updateCartInPrefs(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, jsonEncode(cartItems));
  }
  Future<void> removeFromCart(int id) async {
    final cart = await getCart();
    cart.removeWhere((item) => item.id == id);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cartKey, json.encode(cart.map((item) => item.toJson()).toList()));
  }
}
