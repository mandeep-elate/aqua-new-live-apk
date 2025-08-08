import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:aqaumatic_app/components/count_controller_component_widget.dart';
import 'package:aqaumatic_app/favourite/favorite_service.dart';

import '../../../favourite/favourite_model.dart';
import '../../../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../catalouge_details_page/catalouge_details_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    super.key,
    this.name,

  });

  final String? name;

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  // final FavouriteService _favoritesService = FavouriteService();
  // List<int> favorites = [];
  int count = 0;
  // Future<void> _loadFavorites() async {
  //   List<FavoriteItem> favoritesList = await _favoritesService.getFavourite();
  //   setState(() {
  //     favorites = favoritesList.map((item) => item.id).toList(); // Assuming FavoriteItem has an 'id'
  //   });
  // }
  @override
  void initState() {
    super.initState();
    //_loadFavorites();
    FFAppState().cartCount = 1;
    _loadCart();
    _model = createModel(context, () => SearchPageModel());

    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   context.safePop();
    // });
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
      print(_cartItems.length);
   //   FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FlutterFlowIconButton(
          //  borderColor: Color(0xFF27AEDF),
            borderRadius: 0.0,
            borderWidth: 1.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
             // Navigator.pop(context);
              context.safePop();
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          child: Text(
            'Search ',
            textAlign: TextAlign.justify,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Open Sans',
              color: Colors.white,
              fontSize: 22.0,
              letterSpacing: 0.0,
            ),
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
        // flexibleSpace: FlexibleSpaceBar(
        //
        //   centerTitle: true,
        //   expandedTitleScale: 1.0,
        // ),
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
       child: FutureBuilder<ApiCallResponse>(
            future: GetCatalougeSearchCall.call(catalougeName: widget.name,userId: FFAppState().userId),
            builder: (context, snapshot) {
              // 1. **Loading State**
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(

                    color: Color(0xFF27AEDF),
                    size: 40.0,
                  ),
                );
              }

              // 2. **Error State**
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An error occurred: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              // 3. **No Data State**
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              // 4. **Data Available**
              final listViewGetCatalougeSearchResponse = snapshot.data!;
              final getSearchList = getJsonField(
                listViewGetCatalougeSearchResponse.jsonBody,
                r'''$[:]''',
              );

              // Check if getSearchList is null
              if (getSearchList == null) {
                return Center(
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              // 5. **Handling List Data**
              if (getSearchList is List) {
                if (getSearchList.isEmpty) {
                  return Center(
                    child: Text(
                      'No results found.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  );
                }

                // Build the ListView with data
                return ListView.builder(
                  itemCount: getSearchList.length,
                  itemBuilder: (context, index) {
                    final itemList = getSearchList[index];
                   // bool isFavourite = favorites.contains(itemList['id']);
                    bool isFavorite = itemList['is_favorite'] ?? false;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page
                        context.pushNamed(
                          'CatalougeDetailsPage',
                          queryParameters: {
                            'slugName': serializeParam(
                              itemList['slug'].toString(),
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 15.0, 15.0, 0.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image Container
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    // borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      // Check if images exist and are not empty
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                itemList['images'][0]['src'],
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                                  'assets/images/error_image.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              allowRotation: false,
                                              tag: itemList['images'][0]['src'],
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );

                                    },
                                    child: Hero(
                                      tag: itemList['images'] != null && itemList['images'].isNotEmpty
                                          ? itemList['images'][0]['src']
                                          : 'default_tag', // Fallback tag in case of no images
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: itemList['images'] != null && itemList['images'].isNotEmpty
                                            ? Image.network(
                                          itemList['images'][0]['src'],
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, error, stackTrace) => Image.asset(
                                            'assets/images/error_image.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                            : Image.asset(
                                          'assets/images/error_image.png', // Fallback image in case of no images
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
/*InkWell(
                                    onTap: () async {
                                      // Navigate to expanded image view
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: FlutterFlowExpandedImageView(
                                            image: Image.network(
                                              itemList['images'][0]['src'],
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/error_image.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            allowRotation: false,
                                            tag: itemList['images'][0]['src'],
                                            useHeroAnimation: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: itemList['images'][0]['src'],
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          itemList['images'][0]['src'],
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),*/
                                ),
                                // Details Container
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                      SizedBox(
                                        width: 170.0,
                                        child: Text(
                                          itemList['name'] ?? 'No name',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      // P/N
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'P/N: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                            ),
                                            TextSpan(
                                              text: itemList['sku'] ?? 'No SKU',
                                              style: TextStyle(),
                                            ),
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      // Price
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Price: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                            ),
                                            TextSpan(
                                              text: '£',
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              text: itemList['price'] ?? 'N/A',
                                              style: TextStyle(),
                                            ),
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      // View More Button
                                      InkWell(
                                        onTap: () async {
                                          final slug = itemList['slug'] ?? 'No slug';
                                          final name = itemList['name'] ?? 'No name';
                                          if (slug.isNotEmpty&& name.isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CatalougeDetailsPageWidget(
                                                  slugName: slug,
                                                 name: name,
                                                 // catName: '',
                                                  catName: slug,
                                                ),
                                              ),
                                            );
                                          } else {
                                            print(
                                                'Slug is null, cannot navigate');
                                          }
                                        },
                                        child: Container(
                                          width: 110.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: Color(0xFF019ADE),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  'VIEW MORE',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            Color(0xFF019ADE),
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color(0xFF019ADE),
                                                size: 15.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Actions Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Row(
                                //   children: [
                                //     // Count Controller
                                //     CountControllerComponentWidget(
                                //       countValue: FFAppState().cartCount,
                                //     ),
                                //     SizedBox(width: 15.0),
                                //     // Add to Cart Button
                                //     FFButtonWidget(
                                //       onPressed: () {
                                //         _addItem(
                                //           itemList['id'],
                                //           itemList['name'].toString(),
                                //           itemList['price'].toString(),
                                //           FFAppState().cartCount,
                                //           itemList['sku'],
                                //           itemList['images'][0]['src'],
                                //           itemList['sku'],
                                //         ).then((_) {
                                //           // Show a dialog box after the item has been added successfully
                                //           _showDialog(context, "Item Added", "Item hase been added to the cart");
                                //           FFAppState().cartCount = 1;
                                //         }).catchError((error) {
                                //           // Handle any errors here
                                //           _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                //         });
                                //       },
                                //       text: 'Add',
                                //       icon: Icon(
                                //         Icons.shopping_cart_outlined,
                                //         size: 15.0,
                                //       ),
                                //       options: FFButtonOptions(
                                //         height: 30.0,
                                //         padding: EdgeInsetsDirectional.fromSTEB(
                                //             16.0, 0.0, 16.0, 0.0),
                                //         color: Color(0xFF2DD36F),
                                //        // color: Color(0xFFE00F0F),
                                //         textStyle: FlutterFlowTheme.of(context)
                                //             .titleSmall
                                //             .override(
                                //               fontFamily: 'Open Sans',
                                //               color: Colors.white,
                                //               fontSize: 13.0,
                                //               fontWeight: FontWeight.w600,
                                //             ),
                                //         elevation: 0.0,
                                //         borderSide: BorderSide(
                                //           color: Color(0xFF2DD36F),
                                //        //   color: Color(0xFFE00F0F),
                                //         ),
                                //         borderRadius:
                                //             BorderRadius.circular(8.0),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Spacer(),
                                FFButtonWidget(
                                  onPressed: () async {


                                    // Check if the product is already marked as favorite
                                    if (isFavorite) {
                                      // Make API call to remove from wishlist
                                      final removeResponse = await RemoveProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: itemList['sku'],
                                      );

                                      // Update UI and local state if API call is successful
                                      if (removeResponse.succeeded) {
                                        setState(() {
                                          isFavorite = false;  // Change isFavorite
                                          itemList['is_favorite'] = false;
                                          print('removeResponse-->>${itemList['is_favorite']}');// Sync with item
                                        });
                                      }
                                    } else {
                                      // Make API call to add to wishlist
                                      final addResponse = await AddProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: itemList['sku'],
                                      );

                                      // Update UI and local state if API call is successful
                                      if (addResponse.succeeded) {
                                        setState(() {
                                          isFavorite = true;  // Change isFavorite
                                          itemList['is_favorite'] = true;  // Sync with item

                                          print('addResponse-->>${itemList['is_favorite']}');
                                        });
                                      }
                                    }
                                  },
                                  text: isFavorite ? 'Remove' : 'Add',
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,  // Update icon instantly
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 30.0,
                                    color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),  // Instant color change
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),

                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              // 6. **Handling Map Data**
              else if (getSearchList is Map) {
                final item = getSearchList;
               // bool isFavourite = favorites.contains(item['id']);
                bool isFavorite = item['is_favorite'] ?? false;
                return GestureDetector(
                  onTap: () {
                    // Navigate to details page
                    context.pushNamed(
                      'CatalougeDetailsPage',
                      queryParameters: {
                        'slugName': serializeParam(
                          item['slug'].toString(),
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Container
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                // borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  // Navigate to expanded image view
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          item['images'][0]['src'],
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        allowRotation: false,
                                        tag: item['images'][0]['src'],
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag:  item['images'] != null && item['images'].isNotEmpty
                                      ? item['images'][0]['src']
                                      : 'default_tag', /*item['images'][0]['src'],*/
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: item['images'] != null && item['images'].isNotEmpty
                                        ?Image.network(
                                      item['images'][0]['src'],
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.png',
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ) : Image.asset(
                                      'assets/images/error_image.png', // Fallback image in case of no images
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Details Container
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  SizedBox(
                                    width: 170.0,
                                    child: Text(
                                      item['name'] ?? 'No name',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  // P/N
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'P/N: ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        TextSpan(
                                          text: item['sku'] ?? 'No SKU',
                                          style: TextStyle(),
                                        ),
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  // Price
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Price: ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '£',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: item['price'] ?? 'N/A',
                                          style: TextStyle(),
                                        ),
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  // View More Button
                                  InkWell(
                                    onTap: () async {
                                      final slug = item['slug'] ?? 'No slug';
                                      final name = item['name'] ?? 'No slug';
                                      if (slug.isNotEmpty && name.isNotEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CatalougeDetailsPageWidget(
                                              slugName: slug,
                                              name: name,
                                             // catName: '',
                                                  catName: slug,
                                            ),
                                          ),
                                        );
                                      } else {
                                        print('Slug is null, cannot navigate');
                                      }
                                    },
                                    child: Container(
                                      width: 110.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Color(0xFF019ADE),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'VIEW MORE',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF019ADE),
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xFF019ADE),
                                            size: 15.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Actions Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Count Controller
                                CountControllerComponentWidget(
                                  countValue: FFAppState().cartCount,
                                ),
                                SizedBox(width: 15.0),
                                // Add to Cart Button
                                FFButtonWidget(
                                  onPressed: () {
                                    _addItem(
                                      item['id'],
                                      item['name'].toString(),
                                      item['price'].toString(),
                                      FFAppState().cartCount,
                                      item['sku'],
                                      item['images'][0]['src'],
                                      item['sku'],
                                    ).then((_) {
                                      // Show a dialog box after the item has been added successfully
                                      _showDialog(context, "Item Added", "Item hase been added to the cart");
                                      FFAppState().cartCount = 1;
                                    }).catchError((error) {
                                      // Handle any errors here
                                      _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                    });
                                  },
                                  text: 'Add',
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 30.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    color: Color(0xFF2DD36F),
                                   // color: Color(0xFFE00F0F),
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
                                      color: Color(0xFF2DD36F),
                                    //  color: Color(0xFFE00F0F),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                            // Favourite Button
                            /*FFButtonWidget(
                              onPressed: () async {
                                if (isFavourite) {
                                  await _favoritesService
                                      .removeFromFavourite(item['id']);
                                } else {
                                  FavoriteItem newItem = FavoriteItem(
                                    id: item['id'],
                                    name: item['name'].toString(),
                                    price: item['price'].toString(),
                                    sku: item['sku'],
                                    imageUrl: item['images'][0]['src'],
                                  );
                                  await _favoritesService
                                      .addToFavourite(newItem);
                                }
                                await _loadFavorites();
                              },
                              text: isFavourite ? 'Remove' : 'Add',
                              icon: Icon(
                                Icons.favorite_border,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                               // width: 100.0,
                                height: 30.0,
                                color: isFavourite
                                    ? Color(0xFFE00F0F)
                                    : Color(0xFF27AEDF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: isFavourite
                                      ? Color(0xFFE00F0F)
                                      : Color(0xFF27AEDF),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),*/
                            FFButtonWidget(
                              onPressed: () async {


                                // Check if the product is already marked as favorite
                                if (isFavorite) {
                                  // Make API call to remove from wishlist
                                  final removeResponse = await RemoveProductToWishlistCallNew.call(
                                    userId: FFAppState().userId,
                                    productSku: item['sku'],
                                  );

                                  // Update UI and local state if API call is successful
                                  if (removeResponse.succeeded) {
                                    setState(() {
                                      isFavorite = false;  // Change isFavorite
                                      item['is_favorite'] = false;
                                      print('removeResponse-->>${item['is_favorite']}');// Sync with item
                                    });
                                  }
                                } else {
                                  // Make API call to add to wishlist
                                  final addResponse = await AddProductToWishlistCallNew.call(
                                    userId: FFAppState().userId,
                                    productSku: item['sku'],
                                  );

                                  // Update UI and local state if API call is successful
                                  if (addResponse.succeeded) {
                                    setState(() {
                                      isFavorite = true;  // Change isFavorite
                                      item['is_favorite'] = true;  // Sync with item

                                      print('addResponse-->>${item['is_favorite']}');
                                    });
                                  }
                                }
                              },
                              text: isFavorite ? 'Remove' : 'Add',
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,  // Update icon instantly
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 30.0,
                                color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),  // Instant color change
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: isFavorite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              }

              // 7. **Unexpected Data Type**
              else {
                return Center(
                  child: Text(
                    'Data format error: expected a list but got ${getSearchList.runtimeType}.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            },
          )

      ),
      bottomNavigationBar: CustomBottomNavigationWidget(
        selectedPage: 'catalouge', // Pass the selected page
      ),
    );
  }

  Future<void> _addItem(int id, String name , String price ,int quantity, String pn , String image,String slug) async {
    final newItem = CartItem(id: id, name: name, price: price, quantity: quantity, pn: pn,image: image, slug: slug);
    _cartService.addToCart(newItem);
    _loadCart();
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () async {
                _loadCart();
                final cartItems = await _cartService.getCart();
                setState(() {
                  _cartItems = cartItems;
                  print(_cartItems.length);
                  //FFAppState().cartCount = _cartItems.length;
                  count = _cartItems.length;


                  print('count instant -------$count');
                });
                setState(() {

                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
