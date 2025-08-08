

import '/backend/api_requests/api_calls.dart';
import '/components/count_controller_component_widget.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'catalouge_details_page_widget.dart' show CatalougeDetailsPageWidget;
import 'package:flutter/material.dart';

class CatalougeDetailsPageModel
    extends FlutterFlowModel<CatalougeDetailsPageWidget> {
  ///  Local state fields for this page.

  bool isLike = true;

  bool isRelatedProductLike = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (removeProductWishlist)] action in IconButton widget.
  ApiCallResponse? removeProductWishlist;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildAPI;
  // Stores action output result for [Backend Call - API (addProductToWishlist)] action in IconButton widget.
  ApiCallResponse? addProductWishlist;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildADDAPI;
  // Model for countControllerComponent component.
  late CountControllerComponentModel countControllerComponentModel1;
  // Stores action output result for [Backend Call - API (addToCart)] action in Button widget.
  ApiCallResponse? addToCart;
  // Stores action output result for [Backend Call - API (removeProductWishlist)] action in IconButton widget.
  ApiCallResponse? removeApiCall;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildRelated;
  // Stores action output result for [Backend Call - API (addProductToWishlist)] action in IconButton widget.
  ApiCallResponse? addApiCall;
  // Stores action output result for [Backend Call - API (getProductDetails)] action in IconButton widget.
  ApiCallResponse? rebuildAddRelated;
  // Stores action output result for [Backend Call - API (addToCart)] action in Button widget.
  ApiCallResponse? relatedItemAddToCart;
  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    countControllerComponentModel1 =
        createModel(context, () => CountControllerComponentModel());
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    countControllerComponentModel1.dispose();
    customBottomNavigationModel.dispose();
  }
}
