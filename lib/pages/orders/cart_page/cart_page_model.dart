/*
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'cart_page_widget.dart' show CartPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CartPageModel extends FlutterFlowModel<CartPageWidget> {
  ///  Local state fields for this page.

  int? itemCount;

  dynamic items;

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getCart)] action in CartPage widget.
  ApiCallResponse? cartData;
  // Stores action output result for [Backend Call - API (updateInCart)] action in IconButton widget.
  ApiCallResponse? minusQuantity;
  // Stores action output result for [Backend Call - API (updateInCart)] action in IconButton widget.
  ApiCallResponse? updateQuantity;
  // Stores action output result for [Backend Call - API (deleteItemInCart)] action in Button widget.
  ApiCallResponse? deleteCartItem;
  // Stores action output result for [Backend Call - API (getCart)] action in Button widget.
  ApiCallResponse? getCartList;
  // Stores action output result for [Backend Call - API (createrOrder)] action in Button widget.
  ApiCallResponse? orderCreate;
  // Stores action output result for [Backend Call - API (cartClear)] action in Button widget.
  ApiCallResponse? cartClear;
  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;
  // Stores action output result for [Backend Call - API (cartClear)] action in IconButton widget.
  ApiCallResponse? cartClearAPI;

  @override
  void initState(BuildContext context) {
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    customBottomNavigationModel.dispose();
  }
}
*/
