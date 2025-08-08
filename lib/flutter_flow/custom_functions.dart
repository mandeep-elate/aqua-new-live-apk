

int? getPageNumber(int pageNo) {
  return pageNo + 1;
}

String? getItemKey(
  List<dynamic> cartProducts,
  int? itemId,
) {
  for (var products in cartProducts) {
    if (products['id'] == itemId) {
      return products['item_key'];
    }
  }
  return null;
}

bool isItemInCart(
  List<dynamic>? cartProducts,
  int? itemId,
) {
  if (cartProducts == null) {
    return false;
  } else {
    for (var products in cartProducts) {
      if (products['id'] == itemId) {
        return true;
      }
    }
    return false;
  }
}

int? getItemQuantity(
  List<dynamic> cartProducts,
  int? itemId,
) {
  for (var products in cartProducts) {
    if (products['id'] == itemId) {
      return products['quantity']['value'];
    }
  }
  return 1;
}

int totalCartItem(List<dynamic>? itemList) {
  if (itemList == null) {
    return 0;
  } else {
    int totalItems = 0;
    totalItems = itemList.length;
    return totalItems;
  }
}

dynamic findItemInCart(
  List<dynamic> cartProducts,
  int? itemId,
) {
  for (var products in cartProducts) {
    if (products['id'] == itemId) {
      return products;
    }
  }
  return null;
}

dynamic lineItems(dynamic product) {
  print(product);

  return product!
      .map((product) => {
            "product_id": product['id'],
            "quantity": product['quantity']['value'],
            "SKU": product['meta']['sku']
          })
      .toList();
}

int itemDecreseQuantity(int quantity) {
  return quantity - 1;
}

int? removeFunction(List<dynamic>? wishlist) {
  if (wishlist != null) {
    for (var item in wishlist) {
      //if (item['product_id'] == productId) {
      return item['item_id'];
      // }
    }
  }
  return null;
}

String formatDateTimeCustom(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = months[dateTime.month - 1];
  String year = dateTime.year.toString();
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  // Format as "13 July 2023 - 20:35"
  return '$day $month $year - $hour:$minute';
}

int itemQuantity(int quantity) {
  return quantity + 1;
}
