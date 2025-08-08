import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/favourite/favorite_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cart/cart_service.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'catalouge_details_page_model.dart';
export 'catalouge_details_page_model.dart';


export 'catalouge_details_page_model.dart';

class CatalougeDetailsPageWidget extends StatefulWidget {
  const CatalougeDetailsPageWidget({
    super.key,
    required this.slugName,
    required this.catName,
    required this.name,
  });

  final String? slugName;
  final String? catName;
  final String? name;

  @override
  State<CatalougeDetailsPageWidget> createState() =>
      _CatalougeDetailsPageWidgetState();
}

class _CatalougeDetailsPageWidgetState
    extends State<CatalougeDetailsPageWidget> {
  late CatalougeDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoadingWishlistAction = false;
  bool isLoadingWishlistRelatedAction = false;
  //List<bool> isLoadingWishlistActionMap = [false];
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  final FavouriteService _favoritesService = FavouriteService();
  List<int> favorites = [];
  int count = 0;

  List<dynamic>? relatedProducts1;
  List<int> quantitiesRel = [];
  List<TextEditingController> controllersRel = [];
  int? parsedValueDetails;
  int? parsedValueRel;


  int quantitiesDetails = 1;
  TextEditingController controllersDetails  = TextEditingController(text: '1');
  // Future<void> _loadFavorites() async {
  //   List<FavoriteItem> favoritesList = await _favoritesService.getFavourite();
  //   setState(() {
  //     favorites = favoritesList.map((item) => item.id).toList(); // Assuming FavoriteItem has an 'id'
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _loadFavorites();
    _loadData();
    FFAppState().cartCount = 1;
    _loadCart();
    _model = createModel(context, () => CatalougeDetailsPageModel());

  }



  Future<void> _loadData() async {
    final getProductDetailsResponse = await GetProductDetailsCall.call(
      userId: FFAppState().userId,
      slug: widget.slugName,
    );

    final jsonResponse = getProductDetailsResponse.jsonBody;
    setState(() {
      relatedProducts1 = GetProductDetailsCall.relatedProduct(jsonResponse);

      if (relatedProducts1 != null) {
        quantitiesRel = List<int>.filled(relatedProducts1!.length, 1);
        controllersRel = List<TextEditingController>.generate(
          relatedProducts1!.length,
              (index) => TextEditingController(text: '1'),
        );
      }
    });
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
      //FFAppState().cartCount = _cartItems.length;
      count = _cartItems.length;


      print('count instant -------$count');
    });
  }
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF27AEDF),
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0, 0),
          child: FlutterFlowIconButton(
           // borderColor: Color(0xFF27AEDF),
            borderRadius: 0,
            borderWidth: 0,
            buttonSize: 46,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              size: 24,
            ),
            onPressed: () async {
              Navigator.pop(context);
              //context.safePop();
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
        title: Text(
          valueOrDefault<String>(
            widget.name,
            'slug',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          //minFontSize: 10,
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0.0,
          ),
        ),

        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavigationWidget(
        selectedPage: 'catalouge', // Pass the selected page
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child:FutureBuilder<ApiCallResponse>(
                  future: GetProductDetailsCall.call(
                    userId: FFAppState().userId,
                    slug: widget.slugName,
                  ),
                  builder: (context, snapshot) {
                    // Handle the loading state
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: SpinKitFadingCircle(
                            color: Color(0xFF27AEDF),

                            size: 40,
                          ),
                        ),
                      );
                    }

                    // Fetch the data once available
                    final getProductDetailsResponse = snapshot.data!;
                    final jsonResponse = getProductDetailsResponse.jsonBody;
                    bool isFavourite = GetProductDetailsCall.favourite(jsonResponse)?? false;

                    print('----------- Favourite${GetProductDetailsCall.favourite(jsonResponse)}');
                    // bool isFavourite = favorites.contains(GetProductDetailsCall.id(jsonResponse)!); // Use map access


                    final relatedProducts1 = GetProductDetailsCall.relatedProduct(jsonResponse);

                    // If it's a new page, append the new quantities and controllers


                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(1, -1),
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Builder(
                                      builder: (context) {
                                        // Check if images array is empty or null
                                        final imageList = GetProductDetailsCall.image(jsonResponse);
                                        if (imageList == null || imageList.isEmpty) {
                                          // Handle empty or null image list by showing a placeholder image
                                          return Image.asset(
                                            'assets/images/error_image.png',  // Placeholder or error image
                                            width: double.infinity,
                                            // height: 200,
                                            fit: BoxFit.contain,
                                          );
                                        } else {
                                          // Display the first image from the list
                                          return Image.network(
                                            imageList
                                            /*GetProductDetailsCall.image(jsonResponse)!*/,  // Assuming you want to display the first image
                                            width: double.infinity,
                                            // height: 200,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) => Image.asset(
                                              'assets/images/error_image.png',  // Placeholder if image fails to load
                                              width: double.infinity,
                                              height: 200,
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 10, 0),
                                child: FlutterFlowIconButton(
                                  borderColor: isFavourite
                                      ? Color(0xFFE00F0F)
                                      : Color(0xFF27AEDF),
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: isFavourite
                                      ? Color(0xFFE00F0F)
                                      : Color(0xFF27AEDF),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    size: 24,
                                  ),


                                  onPressed: () async {
                                    if (isFavourite) {
                                      // Make API call to remove from wishlist
                                      final removeResponse = await RemoveProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: GetProductDetailsCall.sku(jsonResponse),
                                      );

                                      // Update UI and local state if API call is successful
                                      if (removeResponse.succeeded) {
                                        setState(() {
                                          isFavourite = false;  // Update isFavourite
                                          // No need to modify jsonResponse
                                          print('Removed from wishlist');
                                        });
                                      }
                                    } else {
                                      // Make API call to add to wishlist
                                      final addResponse = await AddProductToWishlistCallNew.call(
                                        userId: FFAppState().userId,
                                        productSku: GetProductDetailsCall.sku(jsonResponse),
                                      );

                                      // Update UI and local state if API call is successful
                                      if (addResponse.succeeded) {
                                        setState(() {
                                          isFavourite = true;  // Update isFavourite
                                          // No need to modify jsonResponse
                                          print('Added to wishlist');
                                        });
                                      }
                                    }
                                  },



                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  widget.catName == ''
                                      ? valueOrDefault<String>(
                                    GetProductDetailsCall.name(
                                      jsonResponse,
                                    ),
                                    'name',
                                  )
                                      : widget.catName.toString(),
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF43484B),
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                      child: Text(
                                        'P/N :',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 20,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          GetProductDetailsCall.sku(jsonResponse),
                                          'sku',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 20,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      GetProductDetailsCall.name(
                                        jsonResponse,
                                      ),
                                      'name',
                                    ),
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF43484B),
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        'Price: £',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          color: Color(0xFF43484B),

                                          fontFamily: 'Open Sans',
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          GetProductDetailsCall.price(
                                            jsonResponse,
                                          ),
                                          'price',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 16,
                                          color: Color(0xFF43484B),

                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        setState(() {
                                          if (quantitiesDetails > 1) {
                                            quantitiesDetails--;
                                            controllersDetails.text = quantitiesDetails.toString();
                                          }
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.minusCircle,
                                        color:  Color(0xFFEB445A),
                                        size: 25.0,
                                      ),
                                    ),

                                    // TextFormField to display and edit quantity
                                    SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        controller: controllersDetails,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // Check if the input is empty
                                          if (value.isEmpty) {
                                            parsedValueDetails = null; // Set to null if the field is empty
                                          } else {
                                            // Parse and validate the input
                                            parsedValueDetails = int.tryParse(value) ?? 1;
                                            if (parsedValueDetails! < 1) parsedValueDetails = 1; // Clamp minimum value
                                            //if (parsedValue! > 9999) parsedValue = 9999; // Clamp maximum value
                                          }

                                          // Update the controller text only if input is valid
                                          if (parsedValueDetails != null) {
                                            controllersDetails.text = parsedValueDetails.toString();
                                            controllersDetails.selection = TextSelection.fromPosition(
                                              TextPosition(offset: controllersDetails.text.length),
                                            );
                                          }
                                        },
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     // Parse the value, allow 0 or empty temporarily
                                        //     int quantity = int.tryParse(value) ?? 0;
                                        //
                                        //     // Enforce only the maximum limit
                                        //     // if (quantity > 9999) {
                                        //     //   quantity = 9999;
                                        //       controllersDetails.text = quantity.toString(); // Correct input if it exceeds 9999
                                        //       controllersDetails.selection = TextSelection.fromPosition( // Keep cursor at the end
                                        //         TextPosition(offset: controllersDetails.text.length),
                                        //       );
                                        //   //  }
                                        //
                                        //     // Update the quantity
                                        //     quantitiesDetails = quantity;
                                        //   });
                                        // },
                                      ),
                                    ),


                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          // if (controllersDetails.text == '9999') {
                                          //   // Perform any additional logic if required
                                          // }else{

                                            quantitiesDetails++;
                                            controllersDetails.text = quantitiesDetails.toString();
                                         // }
                                        });
                                      },
                                      child: FaIcon(

                                        FontAwesomeIcons.plusCircle,
                                        color:  Color(0xFF2DD36F),
                                        size: 25.0,
                                      ),
                                    ),

                                    // wrapWithModel(
                                    //   model: _model.countControllerComponentModel1,
                                    //   updateCallback: () => safeSetState(() {}),
                                    //   child: CountControllerComponentWidget(countValue: FFAppState().cartCount,),
                                    // ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          // Validate the input: if 0 or invalid, set it to 1
                                          int quantity = int.tryParse(controllersDetails.text) ?? 1;
                                          if (quantity <= 0) {
                                            quantity = 1;
                                            controllersDetails.text = quantity.toString();
                                          }
                                          quantitiesDetails= quantity;
                                        });

                                        _addItem(
                                          GetProductDetailsCall.id(jsonResponse)!,
                                          GetProductDetailsCall.name(jsonResponse)!,
                                          GetProductDetailsCall.price(jsonResponse)!,
                                          int.parse(controllersDetails.text),
                                          //FFAppState().cartCount,
                                          GetProductDetailsCall.sku(jsonResponse)!,
                                          GetProductDetailsCall.image(jsonResponse)!,
                                          GetProductDetailsCall.slug(jsonResponse)!,
                                        ).then((_) {
                                          // Show a dialog box after the item has been added successfully
                                          _showDialog(context, "Item Added", "Item hase been added to the cart");
                                          FFAppState().cartCount = 1;
                                        }).catchError((error) {
                                          // Handle any errors here
                                          _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                        });


                                      },
                                      text: 'Add to cart',
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 30,
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        color: Color(0xFF2DD36F),
                                        // color: Color(0xFF1076BA),
                                        textStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Open Sans',
                                          color: Colors.white,
                                          fontSize: 13,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          // color: Color(0xFF1076BA),
                                          color: Color(0xFF2DD36F),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Related Products Section
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Text(
                              'Associated Items',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Open Sans',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(relatedProducts1!.length, (index) {
                                  final relatedProduct = relatedProducts1[index];
                                  // bool isRelFavourite = favorites.contains(getJsonField(relatedProduct, r'''$.id'''));
                                  bool isRelFavourite = getJsonField(relatedProduct, r'''$.is_favorite''');




                                  // Extract necessary data from the product
                                  final name = getJsonField(relatedProduct, r'''$.name''').toString();
                                  final price = getJsonField(relatedProduct, r'''$.price''').toString();
                                  final sku = getJsonField(relatedProduct, r'''$.sku''').toString();
                                  final image = getJsonField(relatedProduct, r'''$.images[0].src''').toString();
                                  final productId = getJsonField(relatedProduct, r'''$.id''');


                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0, left: 5, bottom: 8,top: 5),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        // Related Product Card
                                        Container(
                                          height: 320,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            //  color: FlutterFlowTheme.of(context).primaryBackground,
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(2, 2),
                                                spreadRadius: 3,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context).accent4,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                // Product Image
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.network(
                                                    getJsonField(
                                                      relatedProduct,
                                                      r'''$.images[0].src''',
                                                    ).toString(),
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error,
                                                        stackTrace) =>
                                                        Image.asset(
                                                          'assets/images/error_image.png',
                                                          fit: BoxFit.contain,
                                                          width: 154,
                                                          height: 100,
                                                        ),
                                                  ),
                                                ),
                                                // Product Details
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width:130,
                                                        child: Text(
                                                          getJsonField(relatedProduct, r'''$.name''')
                                                              .toString(),
                                                          maxLines: 2,
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Open Sans',
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                        child: Text(
                                                          'P/N: ${getJsonField(relatedProduct, r'''$.sku''').toString()}',
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Open Sans',
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                            0, 5, 0, 0),
                                                        child: Text(
                                                          'Price: £${getJsonField(relatedProduct, r'''$.price''').toString()}',
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Open Sans',
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),

                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                print('Controller Text: ${controllersRel[index].text}');
                                                                print('Quantity: ${quantitiesRel[index]}');

                                                                if (quantitiesRel[index] > 1) {
                                                                  quantitiesRel[index]--;
                                                                  // Update the TextEditingController's text
                                                                  controllersRel[index].text = quantitiesRel[index].toString();
                                                                }
                                                              });
                                                            },
                                                            child: FaIcon(
                                                              FontAwesomeIcons.minusCircle,
                                                              color: Color(0xFFEB445A),
                                                              size: 25.0,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                            child: TextFormField(
                                                              controller: controllersRel[index],
                                                              textAlign: TextAlign.center,
                                                              keyboardType: TextInputType.number,
                                                              onChanged: (value) {
                                                                // Check if the input is empty
                                                                if (value.isEmpty) {
                                                                  parsedValueRel = null; // Set to null if the field is empty
                                                                } else {
                                                                  // Parse and validate the input
                                                                  parsedValueRel = int.tryParse(value) ?? 1;
                                                                  if (parsedValueRel! < 1) parsedValueRel = 1; // Clamp minimum value
                                                                  //if (parsedValue! > 9999) parsedValue = 9999; // Clamp maximum value
                                                                }

                                                                // Update the controller text only if input is valid
                                                                if (parsedValueRel != null) {
                                                                  controllersRel[index].text = parsedValueRel.toString();
                                                                  controllersRel[index].selection = TextSelection.fromPosition(
                                                                    TextPosition(offset: controllersRel[index].text.length),
                                                                  );
                                                                }
                                                              },
                                                              // onChanged: (value) {
                                                              //
                                                              //   setState(() {
                                                              //     // Parse the value, allow 0 or empty temporarily
                                                              //     int quantity = int.tryParse(value) ?? 0;
                                                              //
                                                              //     // Apply only the maximum limit
                                                              //     if (quantity > 9999) {
                                                              //       quantity = 9999;
                                                              //       controllersRel[index].text = quantity.toString();
                                                              //     }
                                                              //
                                                              //     // Update the quantity
                                                              //     quantitiesRel[index] = quantity;
                                                              //   });
                                                              //   //controllersRel[index].text = quantitiesRel[index].toString();
                                                              //
                                                              // },
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                print('Controller Text: ${controllersRel[index].text}');
                                                                print('Quantity: ${quantitiesRel[index]}');
                                                                // if (controllersRel[index].text == '9999') {
                                                                //   // Perform any additional logic if required
                                                                // }else{
                                                                  quantitiesRel[index]++;
                                                                  // Update the TextEditingController's text
                                                                  controllersRel[index].text = quantitiesRel[index].toString();
                                                                //}

                                                              });
                                                            },
                                                            child: FaIcon(
                                                              FontAwesomeIcons.plusCircle,
                                                              color: Color(0xFF2DD36F),
                                                              size: 25.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),


                                                      // Add to Cart Button for Related Product
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            setState(() {
                                                              // Validate the input: if 0 or invalid, set it to 1
                                                              int quantity = int.tryParse(controllersRel[index].text) ?? 1;
                                                              if (quantity <= 0) {
                                                                quantity = 1;
                                                                controllersRel[index].text = quantity.toString();
                                                              }
                                                              quantitiesRel[index] = quantity;
                                                            });
                                                            _addItem(
                                                              getJsonField(relatedProduct, r'''$.id''',),
                                                              getJsonField(relatedProduct, r'''$.name''').toString(),
                                                              getJsonField(relatedProduct, r'''$.price''').toString(),
                                                              // FFAppState().cartCount,
                                                              int.parse(controllersRel[index].text),
                                                              getJsonField( relatedProduct,r'''$.sku''').toString(),
                                                              getJsonField(relatedProduct, r'''$.images[0].src''',).toString(),
                                                              getJsonField(relatedProduct, r'''$.slug''').toString(),
                                                            ).then((_) {
                                                              // Show a dialog box after the item has been added successfully
                                                              _showDialog(context, "Item Added", "Item hase been added to the cart");
                                                              FFAppState().cartCount = 1;
                                                            }).catchError((error) {
                                                              // Handle any errors here
                                                              _showDialog(context, "Error", "An error occurred while adding the item to the cart.");
                                                            });

                                                          },
                                                          text: 'Add to cart',
                                                          icon: Icon(
                                                            Icons
                                                                .shopping_cart_outlined,
                                                            size: 15,
                                                          ),
                                                          options: FFButtonOptions(
                                                            //width: 150,
                                                            height: 30,
                                                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                            //color: Color(0xFF1076BA),
                                                            color: Color(0xFF2DD36F),
                                                            textStyle:
                                                            FlutterFlowTheme.of(context).titleSmall.override(
                                                              fontFamily: 'Open Sans',
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                              letterSpacing: 0.0,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                            elevation: 0,
                                                            borderSide: BorderSide(
                                                              //color: Color(0xFF1076BA),
                                                              color: Color(0xFF2DD36F),
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8),
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
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                                          child: FlutterFlowIconButton(
                                            borderColor: isRelFavourite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                            borderRadius: 20,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            fillColor: isRelFavourite ? Color(0xFFE00F0F) : Color(0xFF27AEDF),
                                            icon: Icon(
                                              Icons.favorite,
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              size: 24,
                                            ),
                                            onPressed: () async {
                                              if (isRelFavourite) {
                                                // Make API call to remove from wishlist
                                                final removeResponse = await RemoveProductToWishlistCallNew.call(
                                                  userId: FFAppState().userId,
                                                  productSku:sku,
                                                );

                                                // Update UI and local state if API call is successful
                                                if (removeResponse.succeeded) {
                                                  setState(() {
                                                    isRelFavourite = false;  // Update isFavourite
                                                    relatedProduct['is_favorite'] = false;
                                                    // No need to modify jsonResponse
                                                    print('Removed from wishlist');
                                                  });
                                                }
                                              } else {
                                                // Make API call to add to wishlist
                                                final addResponse = await AddProductToWishlistCallNew.call(
                                                  userId: FFAppState().userId,
                                                  productSku: sku,
                                                );

                                                // Update UI and local state if API call is successful
                                                if (addResponse.succeeded) {
                                                  setState(() {
                                                    isRelFavourite = true;
                                                    relatedProduct['is_favorite'] = true;// Update isFavourite
                                                    // No need to modify jsonResponse
                                                    print('Added to wishlist');
                                                  });
                                                }
                                              }

                                            },
                                          ),
                                        ),



                                      ],
                                    ),
                                  );
                                }),
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

