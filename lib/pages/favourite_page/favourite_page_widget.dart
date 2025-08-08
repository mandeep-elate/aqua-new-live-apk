/*
import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';

import '../../components/customDrawer.dart';
import '../catalouge/catalouge_page/catalouge_page_widget.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/count_controller_component_widget.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'favourite_page_model.dart';
export 'favourite_page_model.dart';

class FavouritePageWidget extends StatefulWidget {
  const FavouritePageWidget({super.key});

  @override
  State<FavouritePageWidget> createState() => _FavouritePageWidgetState();
}

class _FavouritePageWidgetState extends State<FavouritePageWidget> {
  late FavouritePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => FavouritePageModel());
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
            alignment: AlignmentDirectional(0.0, 0.0),
            child: FlutterFlowIconButton(
              //borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 1.0,
              buttonSize: 46.0,
              //fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.menu_rounded,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
              onPressed: () async {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: 15),
              badgeContent: FFAppState().cartCount > 0
                  ? Text(
                FFAppState().cartCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                ),
              )
                  : null,
              showBadge: FFAppState().cartCount > 0,
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
            */
/* FutureBuilder<ApiCallResponse>(
              future: GetCartCall.call(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Wrap();
                }
                final badgeGetCartResponse = snapshot.data!;
                final cartCount = GetCartCall.cartCount(badgeGetCartResponse.jsonBody) ?? 0;
                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -5, end: 15),
                  badgeContent: cartCount > 0
                      ? Text(
                    cartCount.toString(),
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Open Sans',
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                    ),
                  )
                      : null,
                  showBadge: cartCount > 0,
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: Colors.red,
                    elevation: 0.0,

                  )  ,

                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 0.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('CartPage');
                      },
                    ),
                  ),
                );
              },
            ),*//*

          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Favourites',
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


        body: FutureBuilder<ApiCallResponse>(
          future: GetNewWishlistDataCall.call(userId: FFAppState().userId,),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final columnGetNewWishlistDataResponse = snapshot.data!;
            final wishlistItems = GetNewWishlistDataCall.dataList(
                columnGetNewWishlistDataResponse.jsonBody);

            if (wishlistItems == null || wishlistItems.isEmpty) {
              return _emptyWishlist(context);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ...wishlistItems
                      .map((item) => WishlistItem(
                            item: item,
                            model: _model,
                          ))
                      .toList(),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(
          selectedPage: 'favourites', // Pass the selected page
        ),
      ),
    );
  }



  Widget _emptyWishlist(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'No products in wishlist',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Open Sans',
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
          child: FFButtonWidget(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CatalougePageWidget(),));
            },
            text: 'Go to catalogue',
            options: FFButtonOptions(
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              color: Color(0xFF27AEDF),
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'Open Sans',
                color: Colors.white,
              ),
              elevation: 0.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

*/
/*class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: GetNewWishlistDataCall.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),(
                color: FlutterFlowTheme.of(context).primary,
                size: 40.0,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final columnGetNewWishlistDataResponse = snapshot.data!;
        final wishlistItems = GetNewWishlistDataCall.dataList(columnGetNewWishlistDataResponse.jsonBody);

        if (wishlistItems == null || wishlistItems.isEmpty) {
          return _emptyWishlist(context);
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ...wishlistItems.map((item) => WishlistItem(item: item)).toList(),
            ],
          ),
        );
      },
    );
  }


}*//*


class WishlistItem extends StatelessWidget {
  final dynamic item;
  late FavouritePageModel model;

  WishlistItem({required this.item,required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional(0.0, -1.0),
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: FlutterFlowExpandedImageView(
                        image: Image.network(getJsonField(item, r'''$.images[0].src''').toString(), fit: BoxFit.contain),
                        allowRotation: false,
                        tag: getJsonField(item, r'''$.images[0].src''').toString(),
                        useHeroAnimation: true,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: getJsonField(item, r'''$.images[0].src''').toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      getJsonField(item, r'''$.images[0].src''').toString(),
                      width: double.infinity,
                      height: 209.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                right: 10.0,
                child: FlutterFlowIconButton(
                  borderColor: Color(0xFFE00F0F),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: Color(0xFFE00F0F),
                  icon: Icon(
                    Icons.favorite,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    print(getJsonField(item, r'''$.item_id'''));
                    // final removeFavorite = await RemoveProductWishlistCall.call(
                    //   itemId: getJsonField(item, r'''$.item_id'''),
                    // );
                    // if (removeFavorite.succeeded == true) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item removed from favorites')));
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove item')));
                    // }
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'P/N : ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text: getJsonField(
                          item,
                          r'''$.sku''',
                        ).toString(),
                        // getJsonField(
                        // getWishlistApiItem,
                        // r'''$.sku''',
                        // ).toString(),
                        style: TextStyle(),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  getJsonField(
                    item,
                    r'''$.name''',
                  ).toString(),
                  maxLines: 2,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Price : £',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextSpan(
                        text: getJsonField(
                          item,
                          r'''$.price''',
                        ).toString(),
                        style: TextStyle(),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountControllerComponentWidget(
                      //key: Key('Keyvbk_${getWishlistApiIndex}_of_${getWishlistApi.length}'),
                      countValue: FFAppState().cartCount,
                    ),
                    */
/*FFButtonWidget(
                      onPressed: () async {
                        model.addToCart = await AddToCartCall.call(
                          id: getJsonField(
                            item,
                            r'''$.id''',
                          ),
                          quantity: valueOrDefault<int>(
                            FFAppState().cartCount,
                            1,
                          ),
                        );

                        if ((model.addToCart?.succeeded ?? true)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product Added in cart',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product is not added in cart',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }
                      },
                      text: 'Add to cart',
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: 150.0,
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF1076BA),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Color(0xFF1076BA),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),*//*

                  ],
                ),
              ),
            ],
          ),

          // Add other item details here (e.g., SKU, name, price)
        ],
      ),
    );
  }
}*/
