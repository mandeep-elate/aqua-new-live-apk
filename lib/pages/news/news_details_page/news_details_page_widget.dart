import 'package:aqaumatic_app/Cart/CartModel.dart';
import 'package:aqaumatic_app/Cart/cart_page.dart';
import 'package:aqaumatic_app/Cart/cart_service.dart';
import 'package:flutter_html/flutter_html.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'news_details_page_model.dart';
export 'news_details_page_model.dart';
import 'package:html/parser.dart' as html_parser; // For parsing HTML

class NewsDetailsPageWidget extends StatefulWidget {
  const NewsDetailsPageWidget({
    super.key,
    this.slugName,
  });

  final String? slugName;

  @override
  State<NewsDetailsPageWidget> createState() => _NewsDetailsPageWidgetState();
}

class _NewsDetailsPageWidgetState extends State<NewsDetailsPageWidget> {
  late NewsDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    _loadCart();
    _model = createModel(context, () => NewsDetailsPageModel());
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
          leading: FlutterFlowIconButton(
           // borderColor: Color(0xFF27AEDF),
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            //fillColor: Color(0xFF27AEDF),
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
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
              'News Details',
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 15.0),
            child: FutureBuilder<ApiCallResponse>(
              future: GetNewsDetailsCall.call(
                slug: widget.slugName,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                 if (!snapshot.hasData) {
                  return Wrap();
                }
                final columnGetNewsDetailsResponse = snapshot.data!;
                 final htmlContent = GetNewsDetailsCall.content(columnGetNewsDetailsResponse.jsonBody)!;

                 // Parse the HTML content to extract the plain text
                 final document = html_parser.parse(htmlContent);
                 final String parsedText = document.body?.text ?? '';

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8,bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          width:double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5), //border corner radius
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 2, // blur radius
                                offset: Offset(0, 2), // changes position of shadow

                              ),
                            ],
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 8.0, 0.0, 0.0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: functions.formatDateTimeCustom(
                                            GetNewsDetailsCall.date(
                                              columnGetNewsDetailsResponse.jsonBody,
                                            )!),
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF43484B),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          GetNewsDetailsCall.title(
                                            columnGetNewsDetailsResponse.jsonBody,
                                          ),
                                          'title',
                                        ),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF43484B),
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),


                              Html(
                                data: GetNewsDetailsCall.content(
                                  columnGetNewsDetailsResponse.jsonBody,
                                )!,
                                style: {
                                  "p": Style(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    padding: HtmlPaddings.all(0.0), // Correct padding for 'p'
                                  ),
                                  "src": Style(
                                    alignment: Alignment.center, // Align the content to the center
                                   // width: MediaQuery.of(context).size.width * 0.9, // Set the width based on screen size
                                    //height: MediaQuery.of(context).size.height * 0.3, // Adjust height accordingly
                                    display: Display.block, // Ensures the content takes full width
                                    margin: Margins.symmetric(horizontal: 8), // Optional margin
                                  ),
                                },
                              ),

                            ],
                          )
                        ),

                      ],
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
