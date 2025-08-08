
import 'dart:io';

import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/app_constants.dart';
import 'package:aqaumatic_app/backend/api_requests/api_calls.dart';
import 'package:aqaumatic_app/flutter_flow/flutter_flow_util.dart';
import 'package:aqaumatic_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '../flutter_flow/custom_functions.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '../app_state.dart';
import '../components/customDrawer.dart';
import '../components/custom_bottom_navigation_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'CartModel.dart';
import 'dart:developer' as dev;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final CartService _cartService = CartService();
  List<CartItem>? _cartItems; // Allow cart items to be null initially
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic items;
  bool isLoading = false;
  String selectedAddress = 'Billing Address';
  final TextEditingController purchaseOrderController = TextEditingController();
  final TextEditingController customerNotesController = TextEditingController();
   Future<dynamic>? userProfileFuture;
  final _formKey = GlobalKey<FormState>();
  String _deviceType = '';
  int? parsedValue;

  List<int> quantities = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
    getDeviceType();
    userProfileFuture = fetchUserProfile();
  }
  Future<dynamic> fetchUserProfile() async {
    try {
      var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId,);
    //  dev.log('Error fetching user profile: ${userProfile.jsonBody}');
      return userProfile.jsonBody;
      // Return the profile data
    } catch (e) {
      dev.log('Error fetching user profile: $e');
      return null;
    }
  }
  // Future<void> _loadCart() async {
  //   List<CartItem> cart = await _cartService.getCart();
  //   setState(() {
  //     _cartItems = cart;
  //     if (_cartItems != null && _cartItems!.isNotEmpty) {
  //       items = lineItems(_cartItems!); // Use _cartItems to get the products
  //       print("Formatted Line Items: $items");
  //     }
  //   });
  // }
  Future<void> _loadCart() async {
    List<CartItem> cart = await _cartService.getCart();
    setState(() {
      _cartItems = cart;
      if (_cartItems != null && _cartItems!.isNotEmpty) {
        items = lineItems(_cartItems!); // Use _cartItems to get the products
        //print("Formatted Line Items: $items");
      }
      // Debugging output
      //print('Cart items length: ${_cartItems?.length}');
      quantities = _cartItems?.map((item) => item.quantity).toList() ?? [];
      controllers = _cartItems?.map((item) {
        return TextEditingController(text: item.quantity.toString());
      }).toList() ?? [];

      // print('Quantities length: ${quantities.length}');
      // print('Controllers length: ${controllers.length}');
    });
  }


  void getDeviceType() {
    if (Platform.isIOS || Platform.isMacOS) {
      setState(() {
        _deviceType = 'Ios';
        print(_deviceType);
      });
    } else if (Platform.isAndroid) {
      setState(() {
        _deviceType = 'Android';
        print(_deviceType);
      });
    }
  }

  /*Future<void> _loadCart() async {
    // Fetch cart items from SharedPreferences using _cartService
    final cartItems = await _cartService.getCart();

    setState(() {
      _cartItems = cartItems;

      // If cart items are not empty, transform them into the desired format
      if (_cartItems != null && _cartItems!.isNotEmpty) {
        items = lineItems(_cartItems!); // Use _cartItems to get the products
        print("Formatted Line Items: $items");
      }
    });

    // Log cart items quantities to verify
    print("Cart Items after loading: ${_cartItems?.map((item) => item.quantity).toList()}");
  }*/

  dynamic lineItems(List<CartItem> cartItems) {
    // Transform cart items into the required format for order creation
    return cartItems
        .map((item) => {
      "product_id": item.id, // Set 0 if no variation
      "quantity": item.quantity,
      "SKU": item.pn
    }).toList();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCart();  // Load the cart again every time you come back to the cart page
  }

  void _removeItem(int id) async{
    await _cartService.removeFromCart(id);
    _loadCart();
  }

  double _calculateTotal() {
    double total = 0.0;
    if (_cartItems != null) {
      for (var item in _cartItems!) {
        total += double.parse(item.price.toString()) * item.quantity;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: CustomDrawer(
        firstName: FFAppState().firstName,
        lastName: FFAppState().lastName,
        contactNumber: FFAppConstants.contact.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FlutterFlowIconButton(
            //borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 0.0,
            buttonSize: 46.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.menu_sharp,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        actions: [
          _cartItems == null || _cartItems!.isEmpty?Wrap():Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
            child: FlutterFlowIconButton(
            //  borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 0.0,
              buttonSize: 40.0,
              //fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.close,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
             /* onPressed: () async {
                // Check if cart is empty before showing the dialog
                if (_cartItems == null || _cartItems!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Your cart is already empty.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      backgroundColor: Colors.red, // Error color
                      duration: Duration(milliseconds: 3000),
                    ),
                  );
                  return; // Do nothing if the cart is already empty
                }

                // Show confirmation dialog
                bool? confirmed = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Confirm'),
                      content: Text('Are you sure you want to clear the cart?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(false); // User canceled
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(true); // User confirmed
                          },
                          child: Text('Clear Cart'),
                        ),
                      ],
                    );
                  },
                );

                // If the user confirmed, clear the cart
                if (confirmed == true) {
                  await _cartService.clearCart();
                  _loadCart();
                }
              },*/

              onPressed: () async {
                // Show confirmation dialog
                bool? confirmed = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Confirm'),
                      content: Text('Are you sure you want to clear the cart?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(false); // User canceled
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(true); // User confirmed
                          },
                          child: Text('Clear Cart'),
                        ),
                      ],
                    );
                  },
                );

                // If the user confirmed, clear the cart
                if (confirmed == true) {
                  await _cartService.clearCart();
                  _loadCart();
                }
              },
            ),
          ),
        ],

        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Your Cart',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Open Sans',
              color: Colors.white,
              fontSize: 22.0,
              letterSpacing: 0.0,
            ),
          ),
          centerTitle: true,
          expandedTitleScale: 1.0,
        ),
        elevation: 0.0,
      ),
      body: _cartItems == null
          ? Center(child: CircularProgressIndicator()) // Show loading while cart items are being loaded
          : _cartItems!.isEmpty
          ? Center(child: Text('Your cart is empty',style: FlutterFlowTheme.of(context).bodyMedium.override(
        fontFamily: 'Open Sans',
        color: Colors.black,
        fontSize: 18.0,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w600,
      ),))
          : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, // Ensure the ListView takes only as much space as it needs
                padding: EdgeInsets.zero,
                itemCount: _cartItems!.length,
                itemBuilder: (context, index) {
                  final item = _cartItems![index];
                  print(item.image);
                  return Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                item.image,
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error,
                                    stackTrace) =>
                                    Image.asset(
                                      'assets/images/error_image.png',
                                      // fit: BoxFit.contain,
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 2,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'P/N: ',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: item.pn,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Price: £',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: item.price.toString(), // Ensure price is a string
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        setState(() {
                                          if (quantities[index] > 1) {
                                            quantities[index]--;
                                            controllers[index].text = quantities[index].toString();
                                            _decrementQuantity(item.id);
                                          }
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.minusCircle,
                                        color:  Color(0xFFEB445A),
                                        size: 25.0,
                                      ),
                                    ),
                                    /*SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        controller: controllers[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            int parsedValue = int.tryParse(value) ?? 1;

                                            // Enforce the limits
                                            parsedValue = parsedValue.clamp(1, 9999);

                                            quantities[index] = parsedValue;
                                            controllers[index].text = parsedValue.toString();

                                            // Update quantity in the model
                                            updateQuantity(_cartItems![index].id, parsedValue);
                                          });
                                        },
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     // Parse the value directly from the input (onChanged callback)
                                        //     int parsedValue = int.tryParse(value) ?? 1;
                                        //     quantities[index] = parsedValue;
                                        //     updateQuantity(_cartItems![index].id, parsedValue);
                                        //
                                        //     // Update the quantity in the model or cart
                                        //     //_updateQuantity(item.id, parsedValue);
                                        //   });
                                        //
                                        //   // Print the value of the controller (debugging)
                                        //   print('Controller value: ${controllers[index].text}');
                                        // },
                                      ),
                                    ),*/
                                    SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        controller: controllers[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
                                          //LengthLimitingTextInputFormatter(4),   // Limit the max input to 4 digits
                                        ],
                                        onChanged: (value) {
                                          // Check if the input is empty
                                          if (value.isEmpty) {
                                            parsedValue = null; // Set to null if the field is empty
                                          } else {
                                            // Parse and validate the input
                                            parsedValue = int.tryParse(value) ?? 1;
                                            if (parsedValue! < 1) parsedValue = 1; // Clamp minimum value
                                            //if (parsedValue! > 9999) parsedValue = 9999; // Clamp maximum value
                                          }

                                          // Update the controller text only if input is valid
                                          if (parsedValue != null) {
                                            controllers[index].text = parsedValue.toString();
                                            controllers[index].selection = TextSelection.fromPosition(
                                              TextPosition(offset: controllers[index].text.length),
                                            );
                                          }
                                        },

                                        // onChanged: (value) {
                                        //   // Parse and store the value temporarily
                                        //   parsedValue = int.tryParse(value) ?? 1;
                                        //
                                        //   // Clamp the value between 1 and 9999
                                        //   if (parsedValue! < 1) parsedValue = 1;
                                        //   if (parsedValue! > 9999) parsedValue = 9999;
                                        //
                                        //   // Update the controller text to reflect the clamped value
                                        //   controllers[index].text = parsedValue.toString();
                                        //   controllers[index].selection = TextSelection.fromPosition(
                                        //     TextPosition(offset: controllers[index].text.length), // Move cursor to the end
                                        //   );
                                        // },
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // Check if the quantity is less than the maximum value
                                          // if (controllers[index].text == '9999') {
                                          //   // Perform any additional logic if required
                                          // }else{
                                            quantities[index]++;  // Increment the quantity
                                            controllers[index].text = quantities[index].toString();  // Update the controller text
                                            _incrementQuantity(item.id);
                                         // }
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.plusCircle,
                                        color: Color(0xFF2DD36F),
                                        size: 25.0,
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: AlignmentDirectional(0.0, 0.0),
                                    //   child: FlutterFlowIconButton(
                                    //     borderColor: Colors.transparent,
                                    //     borderRadius: 20.0,
                                    //     buttonSize: 35.0,
                                    //     fillColor: Color(0xFFEB445A),
                                    //     icon: FaIcon(
                                    //       FontAwesomeIcons.minus,
                                    //       color: FlutterFlowTheme.of(context).info,
                                    //       size: 20.0,
                                    //     ),
                                    //     showLoadingIndicator: true,
                                    //     onPressed: () async {
                                    //       _decrementQuantity(item.id);
                                    //     },
                                    //   ),
                                    // ),
                                    // Text(
                                    //   '${item.quantity}',
                                    //   style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    //     fontFamily: 'Open Sans',
                                    //     letterSpacing: 0.0,
                                    //   ),
                                    // ),
                                    // FlutterFlowIconButton(
                                    //   borderColor: Colors.transparent,
                                    //   borderRadius: 20.0,
                                    //   buttonSize: 35.0,
                                    //   fillColor:  Color(0xFF2DD36F) ,
                                    //   icon: FaIcon(
                                    //     FontAwesomeIcons.plus,
                                    //     color: FlutterFlowTheme.of(context).info,
                                    //     size: 20.0,
                                    //   ),
                                    //   showLoadingIndicator: true,
                                    //   onPressed: () async {
                                    //     _incrementQuantity(item.id);
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),


                              FFButtonWidget(
                                onPressed: () async {
                                  // Use the stored parsed value to update the quantity
                                  if (parsedValue != quantities[index]) {
                                    await updateQuantity(_cartItems![index].id, parsedValue!);
                                    _loadCart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFF27AEDF),
                                        content: Text('Quantity updated to $parsedValue.'),
                                        duration: Duration(seconds: 2), // Optional: how long the SnackBar will be visible
                                      ),
                                    );
                                  }
                                },
                                text: 'Update',
                                icon: Icon(
                                  Icons.update,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  height: 30.0,
                                  color: Color(0xFF27AEDF),
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF27AEDF),
                                    width: 1.0,
                                  ),
                                ),
                              ),

                              FFButtonWidget(
                                //showLoadingIndicator: true,
                                onPressed: () async {
                                  // _removeItem(item.id);
                                  await _cartService.removeFromCart(item.id);
                                  _removeItem(item.id); // Trigger the callback to refresh favorites
                                },
                                text: 'Remove',
                                icon: Icon(
                                  Icons.close,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  //width: 100.0,
                                  height: 30.0,
                                  color: Color(0xFFE00F0F),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  elevation: 0.0,

                                  borderSide: BorderSide(
                                    color: Color(0xFFE00F0F),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total: £${_calculateTotal().toStringAsFixed(2)}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        fontSize: 23.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),

              ///Radio button add
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                child: Text(
                  'Delivery',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RadioListTile(
                dense: true,
                activeColor:Color(0xFF27AEDF),
                selectedTileColor: Color(0xFF27AEDF),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Billing Address', style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                ),),
                value: 'Billing Address',
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value!;
                  });
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Divider(),
              ),
              RadioListTile(
                activeColor:Color(0xFF27AEDF),
                controlAffinity: ListTileControlAffinity.trailing,
                dense: true,
                selectedTileColor: Color(0xFF27AEDF),
                title: Text('Delivery Address',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                ),),
                value: 'Delivery Address',
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value!;
                  });
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Divider(),
              ),
              RadioListTile(
                activeColor:Color(0xFF27AEDF),
                dense: true,
                selectedTileColor: Color(0xFF27AEDF),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text('Other Address', style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                ),),
                value: 'Other Address',
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value!;
                    print(selectedAddress);
                  });
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 0.0),
                child: Text(
                  // Set the text conditionally based on selectedAddress
                  selectedAddress == 'Billing Address'
                      ? ''
                      : selectedAddress == 'Delivery Address'
                      ? 'Current delivery address'
                      : 'Please enter an alternate address in the customer notes section below',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Text('Details', style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              selectedAddress == 'Delivery Address'
                            ? FutureBuilder<dynamic>(
                                future: userProfileFuture,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child:
                                            CircularProgressIndicator()); // Loading indicator
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error fetching profile data'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Center(
                                        child: Text('No data available'));
                                  }

                                  var userData = snapshot.data;

                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        userData['shipping']['address_1'] ==''?Wrap():Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text('Address :- ${userData['shipping']['address_1'] ?? ''}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        userData['shipping']['city'] ==''?Wrap():Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'City :- ${userData['shipping']['city'] ?? ''}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        userData['shipping']['postcode'] ==''?Wrap(): Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Postcode :- ${userData['shipping']['postcode'] ?? ''}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        userData['shipping']['country'] ==''?Wrap(): Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Country :- ${userData['shipping']['country'] ?? ''}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Wrap(),
                        SizedBox(height: 10),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Text('Purchase Order',style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: TextFormField(
                  controller: purchaseOrderController,
                  //autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context)
                        .bodyMedium
                        .override(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                   // hintText: 'Type Old Password',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                      fontFamily: 'Open Sans',
                      color:
                      FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 13.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                       // color: FlutterFlowTheme.of(context).primaryText,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                        //color: FlutterFlowTheme.of(context).error,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                       // color: FlutterFlowTheme.of(context).error,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  style:
                  FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    letterSpacing: 0.0,
                  ),

                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Text('Customer Notes', style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: TextFormField(
                  maxLines: 4,
                  controller: customerNotesController,
                  //autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context)
                        .bodyMedium
                        .override(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                   // hintText: 'Type Old Password',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                      fontFamily: 'Open Sans',
                      color:
                      FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 13.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),


                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                        //color: FlutterFlowTheme.of(context).primaryText,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                        //color: FlutterFlowTheme.of(context).error,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF43484B),
                        //color: FlutterFlowTheme.of(context).error,

                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  style:
                  FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Open Sans',
                    letterSpacing: 0.0,
                  ),

                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                child: InkWell(

                  onTap: () async {
                    // Fetch user profile
                    var userProfile = await GetUserProfileCall.call(userId: FFAppState().userId,);
                    var userData = userProfile.jsonBody;

                    // Extract user profile data
                    var bFName = GetUserProfileCall.bFName(userData);
                    var bLName = GetUserProfileCall.bLName(userData);
                    var bPhone = GetUserProfileCall.bPhone(userData);
                    var address1 = GetUserProfileCall.bAdd(userData);
                    var address2 = GetUserProfileCall.bAdd2(userData);
                    var city = GetUserProfileCall.bCity(userData);
                    var state = GetUserProfileCall.bState(userData);
                    var postcode = GetUserProfileCall.bPostCode(userData);
                    var country = GetUserProfileCall.bCountry(userData);


                    print('Billing Address Details:');
                    print('First Name: $bFName');
                    print('Last Name: $bLName');
                    print('Phone: $bPhone');
                    print('Address 1: $address1');
                    print('Address 2: $address2');
                    print('City: $city');
                    print('State: $state');
                    print('Postcode: $postcode');
                    print('Country: $country');


                    var shippingFirstName = GetUserProfileCall.shippingFName(userData);
                    var shippingLastName = GetUserProfileCall.shippingLName(userData);
                    var shippingPhone = GetUserProfileCall.shippingPhone(userData);
                    var shippingAddress1 = GetUserProfileCall.shippingAdd(userData);
                    var shippingAddress2 = GetUserProfileCall.shippingAdd2(userData);
                    var shippingCity = GetUserProfileCall.shippingCity(userData);
                    var shippingState = GetUserProfileCall.shippingState(userData);
                    var shippingPostcode = GetUserProfileCall.shippingPostCode(userData);
                    var shippingCountry = GetUserProfileCall.shippingCountry(userData);


                    print('Shipping Address Details:');
                    print('First Name: $shippingFirstName');
                    print('Last Name: $shippingLastName');
                    print('Phone: $shippingPhone');
                    print('Address 1: $shippingAddress1');
                    print('Address 2: $shippingAddress2');
                    print('City: $shippingCity');
                    print('State: $shippingState');
                    print('Postcode: $shippingPostcode');
                    print('Country: $shippingCountry');

                    // Validation check for Other Address
                    if (selectedAddress == 'Other Address') {
                      if (customerNotesController.text.trim().isEmpty) {
                        // Show validation error message if either of the fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please enter your address under the customer notes',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            backgroundColor: Colors.red, // Error color
                            duration: Duration(milliseconds: 3000),
                          ),
                        );
                        return; // Stop execution if validation fails
                      }
                    }
                    // Validation for Billing Address
                    else if (selectedAddress == 'Billing Address') {

                      print(bFName);
                      print(bLName);
                      print(bPhone);
                      print(address1);
                      print(city);
                      print(state);
                      print(postcode);
                      print(country);

                      if (bFName == '' || bLName == '' || bPhone == '' ||
                          address1 == '' || city == '' || state == '' || postcode == '' || country == '') {
                        // Show validation error if any billing field is null
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Your billing address is empty please contact your administrator',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            backgroundColor: Colors.red, // Error color
                            duration: Duration(milliseconds: 3000),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        return; // Stop execution if validation fails
                      }
                    }

                    // Validation for Delivery Address
                    else if (selectedAddress == 'Delivery Address') {
                      if (shippingFirstName == '' || shippingLastName == '' || shippingPhone == '' ||
                          shippingAddress1 == '' || shippingCity == '' || shippingState == '' || shippingPostcode == '' || shippingCountry == '') {
                        // Show validation error if any billing field is null
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Your delivery address is empty please contact your administrator',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            backgroundColor: Colors.red, // Error color
                            duration: Duration(milliseconds: 3000),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        return; // Stop execution if validation fails
                      }
                    }

                    // Show loading indicator
                    setState(() {
                      isLoading = true;
                    });



                    // Create order
                    var orderCreate = await CreateOrderCall.call(
                      // billingFirstName: bFName,
                      // billingLastName: bLName,
                      // billingAddress1:address1 ,
                      // billingAddress2: address2,
                      // billingCity:city ,
                      // billingState: state,
                      // billingPostcode: postcode,
                      // billingCountry:country ,
                      // billingPhone: bPhone,
                      firstName: bFName,
                      lastName: bLName,
                      address1: address1,
                      address2: address2,
                      city: city,
                      state: state,
                      postcode: postcode,
                      country: country,
                      phone: bPhone,
                      customerNote: customerNotesController.text.trim(),
                      shippingFirstName: shippingFirstName,
                      shippingLastName: shippingLastName,
                      shippingAddress1: shippingAddress1,
                      shippingAddress2: shippingAddress2,
                      shippingCity: shippingCity,
                      shippingState: shippingState,
                      shippingPostcode: shippingPostcode,
                      shippingCountry: shippingCountry,
                      shippingPhone: shippingPhone,
                      billingMethod: selectedAddress,
                      purchaseNote: purchaseOrderController.text.trim(),
                      customOrigin: _deviceType,
                      lineItemsJson: items,
                      customerId: FFAppState().userId.toString(),

                    );

                    // Handle order creation result
                    if (orderCreate.succeeded == true) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPageWidget()));
                      await _cartService.clearCart();
                      _loadCart();
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Order not created',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    }
                  },

                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Color(0xFF27AEDF)),
                    child: Center(
                      child: isLoading
                          ? SizedBox(width: 23, height: 23,child: CircularProgressIndicator(color: Colors.white,))
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Submit order to aquamatic'.toUpperCase(),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: '',),
    );
  }

  Future<void> _incrementQuantity(int id) async {
    await _cartService.incrementQuantity(id);
    _loadCart();  // Refresh the cart items after updating quantity
  }

  // Future<void> updateQuantity(int id, int newQuantity) async {
  //   final cartItems = await _cartService.getCart();
  //   final index = cartItems.indexWhere((item) => item.id == id);
  //
  //   if (index != -1) {
  //     // Ensure quantity does not go below 1
  //     cartItems[index].quantity = newQuantity > 0 ? newQuantity : 1;
  //     await _cartService.updateCartInPrefs(cartItems);
  //     _loadCart();
  //   }
  // }
  Future<void> updateQuantity(int id, int newQuantity) async {
    final cartItems = await _cartService.getCart();
    final index = cartItems.indexWhere((item) => item.id == id);

    if (index != -1) {
      // Ensure quantity does not go below 1
      cartItems[index].quantity = newQuantity > 0 ? newQuantity : 1;
      await _cartService.updateCartInPrefs(cartItems);

      // Call _loadCart() only if necessary
      // _loadCart();

      // Update controller text after fetching updated cart items
      setState(() {
        controllers[index].text = cartItems[index].quantity.toString();
      });
    }
  }

  Future<void> _decrementQuantity(int id) async {
    await _cartService.decrementQuantity(id);
    _loadCart();  // Refresh the cart items after updating quantity
  }




}
