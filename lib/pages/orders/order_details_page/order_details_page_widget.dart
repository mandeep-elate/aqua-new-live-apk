import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../Cart/CartModel.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_details_page_model.dart';
export 'order_details_page_model.dart';

class OrderDetailsPageWidget extends StatefulWidget {
  const OrderDetailsPageWidget({
    super.key,
    this.orderId,
  });

  final int? orderId;

  @override
  State<OrderDetailsPageWidget> createState() => _OrderDetailsPageWidgetState();
}

class _OrderDetailsPageWidgetState extends State<OrderDetailsPageWidget> {
  late OrderDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  int count = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => OrderDetailsPageModel());
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
         backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF27AEDF),
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: FlutterFlowIconButton(
             // borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 0.0,
              buttonSize: 46.0,
             // fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
              onPressed: () async {
                context.safePop();
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
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(
          selectedPage: 'orders', // Pass the selected page
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: GetOrderDetailsCall.call(orderId: widget.orderId,),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),
                                size: 40.0,
                              ),
                            ),
                          );
                        }

                        final response = snapshot.data!;
                        final orderDetails = response.jsonBody;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Details',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Order ID
                              _buildDetailRow(context, 'Order ID', GetOrderDetailsCall.id(orderDetails).toString()),
                              // Status
                              _buildDetailRow(context, 'Status', GetOrderDetailsCall.status(orderDetails).toString()),
                              // User Details
                              _buildDetailRow(context, 'User', '${GetOrderDetailsCall.firstName(orderDetails)} ${GetOrderDetailsCall.lastName(orderDetails)}'),
                              // Dates
                              _buildDetailRow(context, 'Date Created', functions.formatDateTimeCustom(GetOrderDetailsCall.createDate(orderDetails).toString())),
                              _buildDetailRow(context, 'Date Updated', functions.formatDateTimeCustom(GetOrderDetailsCall.updatedDate(orderDetails).toString())),
                              // Total
                              _buildDetailRow(context, 'Order Total (£)', GetOrderDetailsCall.total(orderDetails).toString()),
                              // Purchase Order
                              _buildDetailRow(context, 'Purchase Order', 'POR-${GetOrderDetailsCall.number(orderDetails)}'),
                              // // Phone Number
                              // _buildDetailRow(context, 'Phone Number', GetOrderDetailsCall.phoneNumber(orderDetails) ?? 'Phone number not stored'),

                              _buildDetailRow(context, 'Customer Notes', GetOrderDetailsCall.customerNotes(orderDetails) ?? 'Phone number not stored'),

                              _buildDetailRow(context, 'Notes from aquamatic', /*GetOrderDetailsCall.phoneNumber(orderDetails) ?? */'(NONE)'),

                              // Products
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  'Order Parts',
                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF43484B),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              FutureBuilder<ApiCallResponse>(
                                future: GetOrderDetailsCall.call(orderId: widget.orderId,),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: SpinKitFadingCircle(
                                         color: Color(0xFF27AEDF),
                                          size: 40.0,
                                        ),
                                      ),
                                    );
                                  }

                                  final products = getJsonField(snapshot.data!.jsonBody, r'''$.line_items''').toList();

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: products.length,
                                      separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                      itemBuilder: (context, index) {
                                        final product = products[index];
                                        return Container(
                                          width: double.infinity,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              //crossAxisAlignment: CrossAxisAlignment.center,
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      getJsonField(product, r'''$.image.src''').toString(),
                                                      width: 58.0,
                                                      height: 52.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 10.0, 0.0, 0.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      SizedBox(
                                                        width: 250,

                                                        child: Text(
                                                          getJsonField(product, r'''$.name''').toString(),

                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Open Sans',
                                                            color: Colors.black,
                                                            fontSize: 15.0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),

                                                      Text(
                                                        'P/N: ${getJsonField(product, r'''$.sku''').toString()}',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Open Sans',
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Quantity: ${getJsonField(product, r'''$.quantity''').toString()}',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Open Sans',
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10,),
                              /*InkWell(
                                onTap: () async {

                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 45.0,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Color(0xFF2dd26f)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'submit order to apl'.toUpperCase(),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.white,
                                          size: 18.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),*/
                              GetOrderDetailsCall.status(orderDetails).toString() == "cancelled" ?Wrap():InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var orderCancel = await CancelOrderCall.call(
                                    status: 'cancelled',
                                    orderId: widget.orderId,
                                   
                                  );
                                  if (orderCancel.succeeded == true) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    context.go('/orderPage');

                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Order not cancelled',
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
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Color(0xFFeb435a)),
                                  child: Center(
                                    child: isLoading
                                        ? SizedBox(width: 23, height: 23,child: CircularProgressIndicator(color: Colors.white,))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Cancel order'.toUpperCase(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              SizedBox(width: 8.0),
                                              Icon(
                                                Icons.close_sharp,
                                                color: Colors.white,
                                                size: 18.0,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            title,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Open Sans',
              color: Color(0xFF43484B),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Open Sans',
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Divider(color: Color(0xFF43484B),),
        ),
      ],
    );
  }
}
