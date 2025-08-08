import '/backend/api_requests/api_calls.dart';
import '/components/count_controller_component_widget.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'catalouge_list_page_widget.dart' show CatalougeListPageWidget;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class CatalougeListPageModel extends FlutterFlowModel<CatalougeListPageWidget> {
  ///  Local state fields for this page.

  String isLike = 'true';

  List<int> isCount = [];
  void addToIsCount(int item) => isCount.add(item);
  void removeFromIsCount(int item) => isCount.remove(item);
  void removeAtIndexFromIsCount(int index) => isCount.removeAt(index);
  void insertAtIndexInIsCount(int index, int item) =>
      isCount.insert(index, item);
  void updateIsCountAtIndex(int index, Function(int) updateFn) =>
      isCount[index] = updateFn(isCount[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.

  PagingController<ApiPagingParams, dynamic>? listViewPagingController;
  Function(ApiPagingParams nextPageMarker)? listViewApiCall;

  // Stores action output result for [Backend Call - API (addToCart)] action in Button widget.
  ApiCallResponse? addToCart;
  // Stores action output result for [Backend Call - API (removeProductWishlist)] action in Button widget.
  ApiCallResponse? removeProductAPI;
  // Stores action output result for [Backend Call - API (getProductListByCatalouge)] action in Button widget.
  ApiCallResponse? remove;
  // Stores action output result for [Backend Call - API (addProductToWishlist)] action in Button widget.
  ApiCallResponse? addProductWishlistAPI;
  // Stores action output result for [Backend Call - API (getProductListByCatalouge)] action in Button widget.
  ApiCallResponse? add;
  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    listViewPagingController?.dispose();
    customBottomNavigationModel.dispose();
  }

  /// Additional helper methods.
  PagingController<ApiPagingParams, dynamic> setListViewController(
    Function(ApiPagingParams) apiCall,
  ) {
    listViewApiCall = apiCall;
    return listViewPagingController ??= _createListViewController(apiCall);
  }

  PagingController<ApiPagingParams, dynamic> _createListViewController(
    Function(ApiPagingParams) query,
  ) {
    final controller = PagingController<ApiPagingParams, dynamic>(
      firstPageKey: ApiPagingParams(
        nextPageNumber: 0,
        numItems: 0,
        lastResponse: null,
      ),
    );
    return controller
      ..addPageRequestListener(listViewGetProductListByCatalougePage);
  }

  void listViewGetProductListByCatalougePage(ApiPagingParams nextPageMarker) =>
      listViewApiCall!(nextPageMarker)
          .then((listViewGetProductListByCatalougeResponse) {
        print('JSON Response: ${listViewGetProductListByCatalougeResponse.jsonBody}');
        final pageItems = (getJsonField(
                  listViewGetProductListByCatalougeResponse.jsonBody,
                  //r'''$.data''',
                  r'''$[:]''',
                ) ??
                [])
            .toList() as List;
        final newNumItems = nextPageMarker.numItems + pageItems.length;


        listViewPagingController?.appendPage(
          pageItems,
          (pageItems.isNotEmpty)
              ? ApiPagingParams(
                  nextPageNumber: nextPageMarker.nextPageNumber + 1,
                  numItems: newNumItems,
                  lastResponse: listViewGetProductListByCatalougeResponse,
                )
              : null,
        );
      });
}
