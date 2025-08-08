/*
import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';

import '../../../Cart/cart_page.dart';
import '../../../components/customDrawer.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import 'order_page_model.dart';
export 'order_page_model.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({super.key});

  @override
  State<OrderPageWidget> createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
  late OrderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => OrderPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future<void> _loadCart() async {
    final cartItems = await _cartService.getCart();
    setState(() {
      _cartItems = cartItems;
      FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
         backgroundColor: Colors.white,

        drawer: CustomDrawer(
          firstName: FFAppState().firstName,
          lastName: FFAppState().lastName,
          contactNumber: FFAppConstants.contact.toString(),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF27AEDF),
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: AlignmentDirectional(0, 0),
            child: FlutterFlowIconButton(
             // borderColor: Color(0xFF27AEDF),
              borderRadius: 0,
              borderWidth: 1,
              buttonSize: 46,
             // fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.menu_sharp,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24,
              ),
              onPressed: () async {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: 15),
              //badgeContent: FFAppState().cartCount > 0
              badgeContent: count > 0
                  ? Text(
                //FFAppState().cartCount.toString(),
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                ),
              )
                  : null,
              //showBadge: FFAppState().cartCount > 0,
              showBadge: count > 0,
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.red,
                elevation: 0.0,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  onPressed: () {
                    // Navigate to Cart Page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                ),
              ),
            ),

          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Orders',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Open Sans',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0.0,
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(
          selectedPage: 'orders', // Pass the selected page
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            safeSetState(() => _model.listViewPagingController?.refresh());
            await _model.waitForOnePageForListView();
          },
          child: PagedListView<ApiPagingParams, dynamic>*/
/*.separated*//*
(

            pagingController: _model.setListViewController(
                  (nextPageMarker) => GetOrderListCall.call(
                page: functions
                    .getPageNumber(nextPageMarker.nextPageNumber)
                    .toString(),
                userId: FFAppState().userId,
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              0,
            ),
            shrinkWrap: true,
            reverse: false,
            scrollDirection: Axis.vertical,
            //separatorBuilder: (_, __) => SizedBox(height: 15),
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
              // Customize what your widget looks like when it's loading the first page.
              firstPageProgressIndicatorBuilder: (_) => Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 40.0,
                  ),
                ),
              ),
              // Customize what your widget looks like when it's loading another page.
              newPageProgressIndicatorBuilder: (_) => Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 40.0,
                  ),
                ),
              ),


              itemBuilder: (context, _, getOrderIndex) {
                final getOrderItem = _model.listViewPagingController!.itemList![getOrderIndex];

                print(getOrderItem);

                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        'OrderDetailsPage',
                        queryParameters: {
                          'orderId': serializeParam(
                            getJsonField(
                              getOrderItem,
                              r'''$.id''',
                            ),
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 110,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .primaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) {
                              final status = getJsonField(
                                      getOrderItem, r'''$.status''')
                                  .toString();

                              // Define a map of status to corresponding button properties with proper typing
                              final Map<String,
                                      Map<String, dynamic>>
                                  statusMap = {
                                _model.orderCancel: {
                                  'borderColor': Color(0xFFFF0000),
                                  'fillColor': Color(0xFFFF0000),
                                  'icon': Icons.close_outlined,
                                },
                                _model.orderProcessing: {
                                  'borderColor':
                                      FlutterFlowTheme.of(context)
                                          .warning,
                                  'fillColor':
                                      FlutterFlowTheme.of(context)
                                          .warning,
                                  'icon':
                                      Icons.sync_problem_outlined,
                                },
                                _model.orderPending: {
                                  'borderColor':
                                      FlutterFlowTheme.of(context)
                                          .warning,
                                  'fillColor':
                                      FlutterFlowTheme.of(context)
                                          .warning,
                                  'icon': Icons.pending,
                                },
                                _model.orderComplete: {
                                  'borderColor': Color(0xB22EAB03),
                                  'fillColor': Color(0xB22EAB03),
                                  'icon': Icons.check_sharp,
                                },
                              };

                              // Check if the status exists in the map, else show default container
                              if (statusMap.containsKey(status)) {
                                final properties =
                                    statusMap[status]!;
                                return FlutterFlowIconButton(
                                  borderColor:
                                      properties['borderColor']
                                          as Color?,
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: properties['fillColor']
                                      as Color?,
                                  icon: Icon(
                                    properties['icon'] as IconData?,
                                    color:
                                        FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                );
                              } else {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context)
                                            .warning,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment:
                                      AlignmentDirectional(0, 0),
                                  child: Text(
                                    status,
                                    style:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  'Open Sans',
                                              fontSize: 10,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25, 5, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional
                                      .fromSTEB(0, 5, 0, 0),
                                  child: RichText(
                                    textScaler:
                                    MediaQuery.of(context)
                                        .textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Order ID: - ',
                                          style: FlutterFlowTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'Open Sans',
                                            color: Colors.black,
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: getJsonField(
                                            getOrderItem,
                                            r'''$.id''',
                                          ).toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional
                                      .fromSTEB(0, 5, 0, 0),
                                  child: RichText(
                                    textScaler:
                                    MediaQuery.of(context)
                                        .textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Status :- ',
                                          style: FlutterFlowTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'Open Sans',
                                            color: Colors.black,
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: getJsonField(
                                            getOrderItem,
                                            r'''$.status''',
                                          ).toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional
                                      .fromSTEB(0, 5, 0, 0),
                                  child: RichText(
                                    textScaler:
                                    MediaQuery.of(context)
                                        .textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Updated  ',
                                          style: FlutterFlowTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'Open Sans',
                                            color: Color(
                                                0xFF43484B),
                                            fontSize: 16,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: functions
                                              .formatDateTimeCustom(
                                              getJsonField(
                                                getOrderItem,
                                                r'''$.date_created''',
                                              ).toString()),
                                          style: TextStyle(),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Open Sans',
                                        color:
                                        Color(0xFF43484B),
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional
                                      .fromSTEB(0, 8, 0, 0),
                                  child: Container(
                                    width: 283,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/
import 'package:aqaumatic_app/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Cart/CartModel.dart';
import '../../../Cart/cart_page.dart';
import '../../../Cart/cart_service.dart';
import '../../../app_state.dart';
import '../../../backend/api_requests/api_calls.dart';
import '../../../components/customDrawer.dart';
import '../../../components/custom_bottom_navigation_widget.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
// Import your services and models
// import 'package:your_project/services/get_order_list_call.dart';
// import 'package:your_project/services/favorites_service.dart';
// import 'package:your_project/models/favorite_item.dart';
// import 'package:your_project/widgets/flutter_flow_icon_button.dart';
// import 'package:your_project/widgets/ff_button_widget.dart';
// import 'package:your_project/widgets/count_controller_component_widget.dart';
// import 'package:your_project/widgets/flutter_flow_expanded_image_view.dart';
// import 'package:your_project/pages/order_details_page.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({super.key});

  @override
  _OrderPageWidgetState createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
  static const _pageSize = 10;

  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 1);
  final CartService _cartNewService = CartService();
  List<CartItem> _cartItems = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int count = 0;


  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _loadFavorites() async {
    _cartItems = await _cartNewService.getCart();
    setState(() {
      _cartItems = _cartItems;
      FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await GetOrderListCall.call(
        page: pageKey.toString(),
        userId: FFAppState().userId, // Assuming FFAppState().userId exists
      );

      // Parse the response to extract the list of orders
      final List<dynamic> fetchedOrders = response.jsonBody as List<dynamic>;

      final isLastPage = fetchedOrders.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(fetchedOrders);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(fetchedOrders, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _addItem(
      int id,
      String name,
      double price,
      int count,
      String sku,
      String imageUrl,
      ) async {
    // Implement your add item functionality here
    // For example, add to cart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
       backgroundColor: Colors.white,

      drawer: CustomDrawer(
        firstName: FFAppState().firstName,
        lastName: FFAppState().lastName,
        contactNumber: FFAppConstants.contact.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0, 0),
          child: FlutterFlowIconButton(
            // borderColor: Color(0xFF27AEDF),
            borderRadius: 0,
            borderWidth: 1,
            buttonSize: 46,
            // fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.menu_sharp,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -5, end: 15),
            //badgeContent: FFAppState().cartCount > 0
            badgeContent: count > 0
                ? Text(
              //FFAppState().cartCount.toString(),
              count.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                letterSpacing: 0.0,
              ),
            )
                : null,
            //showBadge: FFAppState().cartCount > 0,
            showBadge: count > 0,
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.red,
              elevation: 0.0,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () {
                  // Navigate to Cart Page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
            ),
          ),

        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Orders',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Open Sans',
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
          centerTitle: true,
          expandedTitleScale: 1.0,
        ),
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavigationWidget(
        selectedPage: 'orders', // Pass the selected page
      ),
      body: PagedListView<int, dynamic>(
        pagingController: _pagingController,
        //padding: EdgeInsets.zero,
        shrinkWrap: false,
        reverse: false,
        scrollDirection: Axis.vertical,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          // First page loading indicator
          firstPageProgressIndicatorBuilder: (_) => Center(
            child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),
              size: 40.0,
            ),
          ),
          // New page loading indicator
          newPageProgressIndicatorBuilder: (_) => Center(
            child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),
              size: 40.0,
            ),
          ),
          // Error indicator
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Text(
              'An error occurred while fetching orders.',
              style: TextStyle(color: Colors.red),

            ),
          ),
          // Empty list indicator
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: Text(
              'No orders found.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          // Item builder
          itemBuilder: (context, item, index) {
            final getOrderItem = item;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: InkWell(
                onTap: () {
                  context.pushNamed(
                    'OrderDetailsPage',
                    queryParameters: {
                      'orderId': serializeParam(
                        getJsonField(
                          getOrderItem,
                          r'''$.id''',
                        ),
                        ParamType.int,
                      ),
                    }.withoutNulls,
                  );
                  // Navigate to Order Details Page
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.fade,
                  //     child: OrderDetailsPage(orderId: getOrderItem['id']),
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  //padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    //color: Theme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      // Status Icon
                      Builder(
                        builder: (context) {
                          final status =
                          getOrderItem['status'].toString().toLowerCase();
                          final Map<String, Map<String, dynamic>> statusMap = {
                            'cancelled': {
                              'borderColor': Colors.red,
                              'fillColor': Colors.red,
                              'icon': Icons.close_outlined,
                            },
                            'on-hold': {
                              'borderColor': Colors.grey,
                              'fillColor': Colors.grey,
                              'icon': Icons.back_hand_outlined,
                            },
                            'processing': {
                              'borderColor': Colors.orange,
                              'fillColor': Colors.orange,
                              'icon': Icons.sync_problem_outlined,
                            },
                            'pending': {
                              'borderColor': Colors.yellow,
                              'fillColor': Colors.yellow,
                              'icon': Icons.pending,
                            },
                            'completed': {
                              'borderColor': Colors.green,
                              'fillColor': Colors.green,
                              'icon': Icons.check_sharp,
                            },
                            'dispatched': {
                              'borderColor': Colors.red,
                              'fillColor': Colors.red,
                              'icon': Icons.delivery_dining,
                            },
                          };
      
                          if (statusMap.containsKey(status)) {
                            final properties = statusMap[status]!;
                            return Container(
                              decoration: BoxDecoration(
                                color: properties['fillColor'],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: properties['borderColor'],
                                  width: 2.0,
                                ),
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                properties['icon'],
                                color: Colors.white,
                                size: 24.0,
                              ),
                            );
                          } else {
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(width: 25.0),
                      // Order Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Order ID
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Order ID: ',
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily:
                                      'Open Sans',
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: getOrderItem['id'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            // Status
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Status: ',
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily:
                                      'Open Sans',
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: getOrderItem['status'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            // Updated Date
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Updated: ',
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily:
                                      'Open Sans',
                                      color: Color(
                                          0xFF43484B),
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: functions
                                        .formatDateTimeCustom(
                                        getJsonField(
                                          getOrderItem,
                                          r'''$.date_created''',
                                        ).toString()),
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily:
                                      'Open Sans',
                                      color: Color(
                                          0xFF43484B),
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            // Divider
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
