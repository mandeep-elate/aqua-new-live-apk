import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCatalougeCall {
  static Future<ApiCallResponse> call({
    String? page = '1',
    int? userId,


  }) async {
    print(userId);
    ApiCallResponse response = await ApiManager.instance.makeApiCall(
      callName: 'getCatalouge',
      apiUrl:
      '${FFAppConstants.baseUrl}wp-json/wc/v3/products/categories?per_page=10&user_id=$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the JSON body of the API response
    debugPrint(response.jsonBody.toString());

    return response;
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GetOrderListCall {
  static Future<ApiCallResponse> call({
    String? page = '1',
    int? userId,
  }) async {

    print('User ID: $userId');

    final response = await ApiManager.instance.makeApiCall(
      callName: 'getOrderList',
      apiUrl:
      '${FFAppConstants.baseUrl}wp-json/wc/v3/orders?per_page=10&customer=$userId',
      //'${FFAppConstants.baseUrl}wp-json/wc/v3/orders?customer=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {
        //'customer':userId,
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the raw API response for debugging
    dev.log('API Response: ${response.jsonBody}');

    return response;
  }

  static List<int>? orderId(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? status(dynamic response) => (getJsonField(
    response,
    r'''$[:].status''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GetCatalougeSearchCall {
  static Future<ApiCallResponse> call({
    String? catalougeName = '',
    int?userId
  }) async {
    final response = await ApiManager.instance.makeApiCall(
    //return ApiManager.instance.makeApiCall(
      callName: 'getCatalougeSearch',
      apiUrl:
          '${FFAppConstants.baseUrl}wp-json/wc/v3/products?search=$catalougeName&user_id=$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            FFAppConstants.basicAuth,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    dev.log('-----${response.jsonBody.toString()}');
    return response;
  }

}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? password = '',
    String? username = '',
  }) async {
    final ffApiRequestBody =
        '''{ "username": "$username","password": "$password"}''';

    print('BodyType.JSON: $ffApiRequestBody');
    print('BodyType.JSON: $username');
    print('BodyType.JSON: $password');
    /*return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/custom/v1/login',
     // apiUrl: '${FFAppConstants.baseUrl}wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );*/
    final response = await ApiManager.instance.makeApiCall(
      callName: 'login',
     //apiUrl: '${FFAppConstants.baseUrl}wp-json/custom/v1/login',
     apiUrl: '${FFAppConstants.baseUrl}wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the entire response
    print('Login Response: ${response.jsonBody}');

    return response;
  }



  static String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.email''',
      ));
  static String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.firstName''',
      ));
  static String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.lastName''',
      ));
  static String? displayName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.displayName''',
      ));
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static String? shareKey(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.wishlist.share_key''',
  ));
  static int? wishlistId(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.wishlist.id''',
  ));

}

class GetProductListByCatalougeCall {
  static Future<ApiCallResponse> call({
    int? categoryId,
    int? page,
    int? userId,
  }) async {


    // Call the API and capture the response
    final response = await ApiManager.instance.makeApiCall(
      callName: 'getProductListByCatalouge',
     // apiUrl: '${FFAppConstants.baseUrl}wp-json/custom/v1/products?per_page=10&category=${categoryId}&user_id=${userId}',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/wc/v3/products?per_page=10&category=$categoryId&user_id=$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the entire response to see the structure
   dev.log('API Response: ${response.jsonBody}');

    // Return the response
    return response;
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<String>? fav(dynamic response) => (getJsonField(
    response,
    //r'''$.data[:].is_favourite''',
    r'''$[:].is_favourite''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GetProductDetailsCall {
  static Future<ApiCallResponse> call({
    String? slug = '',
    required int userId,
  }) async {

    print(slug);
    print(userId);

    final response = await ApiManager.instance.makeApiCall(
      callName: 'getProductDetails',
      apiUrl:
     '${FFAppConstants.baseUrl}wp-json/custom/v1/product-detail?slug=$slug&user_id=$userId',
      //'${FFAppConstants.baseUrl}wp-json/wc/v3/products?slug=${slug}&user_id=${userId}',
      callType: ApiCallType.GET,
      // headers: {
      //   'Authorization':
      //   '${FFAppConstants.basicAuth}',
      // },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the response for debugging
   dev.log('response ${response.jsonBody}');

    return response;

  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  static String? slug(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.slug''',
      ));
  static String? sku(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.sku''',
      ));
  static String? price(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.price''',
      ));
  static String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.images[:].src''',
      ));
  static List? relatedProduct(dynamic response) => getJsonField(
        response,
        r'''$.data.related_products''',
        true,
      ) as List?;
  static bool? favourite(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.is_favorite''',
      ));
  static int? itemid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.item_id''',
      ));
}

class AddProductToWishlistCallNew {
  static Future<ApiCallResponse> call({
    int? userId,
    String? productSku,
  }) async {

    print(productSku);
    // Make the API call and capture the response
    ApiCallResponse response = await ApiManager.instance.makeApiCall(
      callName: 'addProductToWishlist',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/favorite-products/v1/favorites/add',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {
        'user_id': userId,
        'product_sku': productSku,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      // bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the response body
    print(response.jsonBody);

    return response;
  }

  static List? products(dynamic response) => getJsonField(
    response,
    r'''$.items''',
    true,
  ) as List?;
}

class RemoveProductToWishlistCallNew {
  static Future<ApiCallResponse> call({
    int? userId,
    String? productSku,
  }) async {

    return ApiManager.instance.makeApiCall(
      callName: 'removeProductToWishlist',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/favorite-products/v1/favorites/remove',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {
        'user_id': userId,
        'product_sku': productSku,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      // bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? products(dynamic response) => getJsonField(
    response,
    r'''$.items''',
    true,
  ) as List?;
}


class GetFavouritesListCall {
  static Future<ApiCallResponse> call({
    int? userId,
    //required String token,
  }) async {

    print('User ID: $userId');

    final response = await ApiManager.instance.makeApiCall(
      callName: 'getFavouritesList',
      apiUrl:
      '${FFAppConstants.baseUrl}wp-json/favorite-products/v1/favorites/all?user_id=$userId',
      //'${FFAppConstants.baseUrl}wp-json/wc/v3/orders?customer=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
       // 'Basic $token',
        FFAppConstants.basicAuth,
      },

      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the raw API response for debugging
    dev.log('API Response: ${response.jsonBody}');

    return response;
  }

  static List<int>? orderId(dynamic response) => (getJsonField(
    response,
    r'''$[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? status(dynamic response) => (getJsonField(
    response,
    r'''$[:].status''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GetNewsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getNews',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/wp/v2/posts',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetNewsDetailsCall {
  static Future<ApiCallResponse> call({
    String? slug = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getNewsDetails',
      apiUrl:
          '${FFAppConstants.baseUrl}wp-json/wp/v2/posts?slug=$slug',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].id''',
      ));
  static String? date(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].date''',
      ));
  static String? slug(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].slug''',
      ));
  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].title.rendered''',
      ));
  static String? content(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].content.rendered''',
      ));
}

class GetOrderDetailsCall {
  static Future<ApiCallResponse> call({
    int? orderId,
  }) async {
    // Make the API call
    ApiCallResponse response = await ApiManager.instance.makeApiCall(
      callName: 'getOrderDetails',
      apiUrl:
      '${FFAppConstants.baseUrl}wp-json/wc/v3/orders/$orderId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the API response for debugging
    dev.log('API Response: ${response.jsonBody}');

    // Return the API response
    return response;
  }

  static int? id(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.id''',
  ));
  static String? status(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.status''',
  ));
  static String? currency(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.currency''',
  ));
  static String? createDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.date_created''',
      ));
  static String? total(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.total''',
  ));
  static String? updatedDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.date_modified''',
      ));
  static String? firstName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.first_name''',
  ));
  static String? lastName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.last_name''',
  ));
  static String? number(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.number''',
  ));
  static String? phoneNumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.shipping.phone''',
      ));
  static List? lineItems(dynamic response) => getJsonField(
    response,
    r'''$.line_items''',
    true,
  ) as List?;
  static String? customerNotes(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.customer_note''',
  ));
}

class GetUserProfileCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getUserProfile',
      apiUrl:
          '${FFAppConstants.baseUrl}wp-json/wc/v3/customers/$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            FFAppConstants.basicAuth,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic billing(dynamic response) => getJsonField(
        response,
        r'''$.billing''',
      );

  static int? id(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.id''',
  ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.email''',
  ));
  static String? fName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.first_name''',
  ));
  static String? lName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.last_name''',
  ));
  static String? role(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.role''',
  ));
  static String? userName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.username''',
  ));
  static String? bFName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.first_name''',
  ));
  static String? bLName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.last_name''',
  ));
  static String? bPostCode(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.postcode''',
  ));
  static String? bEmail(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.email''',
  ));
  static String? bPhone(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.phone''',
  ));
  static String? bAdd(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.address_1''',
  ));
  static String? bAdd2(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.address_2''',
  ));
  static String? bCity(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.city''',
  ));
  static String? bCountry(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.country''',
  ));
  static String? bState(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.billing.state''',
  ));

  static String? shippingFName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.first_name''',
  ));
  static String? shippingLName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.last_name''',
  ));
  static String? shippingPostCode(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.postcode''',
  ));
  static String? shippingEmail(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.email''',
  ));
  static String? shippingPhone(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.phone''',
  ));
  static String? shippingAdd(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.address_1''',
  ));
  static String? shippingAdd2(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.address_2''',
  ));
  static String? shippingCity(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.city''',
  ));
  static String? shippingCountry(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.country''',
  ));
  static String? shippingState(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.shipping.state''',
  ));
}

class CreateOrderCall {
  static Future<ApiCallResponse> call({
    String? customerNote = '',
    String? billingMethod = '',
    String? purchaseNote = '',
    String? firstName = '',
    String? lastName = '',
    String? address1 = '',
    String? address2 = '',
    String? city = '',
    String? state = '',
    String? postcode = '',
    String? country = '',
    String? phone = '',
    String? shippingFirstName = '',
    String? shippingLastName = '',
    String? shippingAddress1 = '',
    String? shippingAddress2 = '',
    String? shippingCity = '',
    String? shippingState = '',
    String? shippingPostcode = '',
    String? shippingCountry = '',
    String? shippingPhone = '',
    String? customOrigin = '',
    dynamic lineItemsJson,
    String? customerId = '',
  }) async {
    final lineItems = _serializeJson(lineItemsJson);
    final ffApiRequestBody = '''
    
     
{
  "payment_method": "bacs",
  "payment_method_title": "Direct Bank Transfer",
  "set_paid": true,
  "status":"pending",
  "customer_id": "$customerId",
  "billing": {
    "first_name": "$firstName",
    "last_name": "$lastName",
    "address_1": "$address1",
    "address_2": "$address2",
    "city": "$city",
    "state": "$state",
    "postcode": "$postcode",
    "country": "$country",
    "phone": "$phone"
  },
  "shipping": {
    "first_name": "$shippingFirstName",
    "last_name": "$shippingLastName",
    "address_1": "$shippingAddress1",
    "address_2": "$shippingAddress2",
    "city": "$shippingCity",
    "state": "$shippingState",
    "postcode": "$shippingPostcode",
    "country": "$shippingCountry"
  },
  "customer_note" : "$customerNote",
  "meta_data": [
        {
           "key": "selected billing method",
            "value": "$billingMethod"
        },
        {
           "key": "purchase note",
            "value": "$purchaseNote"
        },
         {
           "key": "Custom Origin",
            "value": "$customOrigin"
        }
        ],
  "line_items": $lineItems,
  "shipping_lines": [
    {
      "method_id": "flat_rate",
      "method_title": "Flat Rate",
      "total": "0.00"
    }
  ]
}''';

    dev.log('BodyType.JSON: $ffApiRequestBody');
    return ApiManager.instance.makeApiCall(
      callName: 'createrOrder',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/wc/v3/orders',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            FFAppConstants.basicAuth,
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CancelOrderCall {
  static Future<ApiCallResponse> call({
    String? status = '',
    int? orderId
  }) async {
    final ffApiRequestBody = '''
    {
 "status" : "$status"
}''';

    print('BodyType.JSON: $ffApiRequestBody');
    return ApiManager.instance.makeApiCall(
      callName: 'createrOrder',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/wc/v3/orders/$orderId',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
        FFAppConstants.basicAuth,
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDownloadDataListCall {
  static Future<ApiCallResponse> call() async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'getDownloadDataList',
      apiUrl:
      '${FFAppConstants.baseUrl}wp-json/custom/v1/downloads',
      callType: ApiCallType.GET,
      // headers: {
      //   'Authorization':
      //   '${FFAppConstants.basicAuth}',
      // },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the raw response to the console
    print('API Response: ${response.jsonBody}');

    return response;
  }
}

class ChangePasswordCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? password = '',
    String? newPassword = '',
  }) async {
    final response = await ApiManager.instance.makeApiCall(
      callName: 'changePassword',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/custom/v1/change-password',
      callType: ApiCallType.POST,
      params: {
        'user_id': userId,
        'password': password,
        'new_password': newPassword,
      },
      // headers: {
      //   'Authorization':
      //   '${FFAppConstants.basicAuth}',
      // },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the raw API response to the console
    print('API Response: ${response.jsonBody}');

    return response;
  }
}



class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
class SearchProductBySkuCall {
  static Future<ApiCallResponse> call({required String sku}) {
    return ApiManager.instance.makeApiCall(
      callName: 'SearchProductBySku',
      apiUrl: '${FFAppConstants.baseUrl}wp-json/wc/v3/products',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': FFAppConstants.basicAuth,
      },
      params: {
        'sku': sku,
      },
      returnBody: true,
      cache: false,
    );
  }
}
