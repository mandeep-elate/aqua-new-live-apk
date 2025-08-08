/*
import 'package:aqaumatic_app/components/customDrawer.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
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
import 'cart_page_model.dart';
export 'cart_page_model.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({super.key});

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  late CartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.cartData = await GetCartCall.call();

      if ((_model.cartData?.succeeded ?? true)) {
        _model.items = functions.lineItems(getJsonField(
          (_model.cartData?.jsonBody ?? ''),
          r'''$.items''',
        ));
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: GetCartCall.call(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
             backgroundColor: Colors.white,
            body: Center(
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
            bottomNavigationBar: CustomBottomNavigationWidget(
              selectedPage: 'favourites', // Pass the selected page
            ),
          );
        }
        final cartPageGetCartResponse = snapshot.data!;

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
                  borderColor: Color(0xFF27AEDF),
                  borderRadius: 0.0,
                  borderWidth: 0.0,
                  buttonSize: 46.0,
                  fillColor: Color(0xFF27AEDF),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0xFF27AEDF),
                    borderRadius: 0.0,
                    borderWidth: 0.0,
                    buttonSize: 40.0,
                    fillColor: Color(0xFF27AEDF),
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                child: AlertDialog(
                                  title: Text('Cart clear'),
                                  content: Text(
                                      'Are you sure want to empty your cart?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        _model.cartClearAPI = await CartClearCall.call();

                        if ((_model.cartClearAPI?.succeeded ?? true)) {
                          safeSetState(() {});
                        } else {
                          safeSetState(() {});
                        }
                      } else {
                        context.safePop();
                      }

                      safeSetState(() {});
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
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 70.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: GetCartCall.call(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
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
                          }
                          final columnGetCartResponse = snapshot.data!;

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (GetCartCall.items(
                                                columnGetCartResponse.jsonBody,
                                              ) !=
                                              null &&
                                          (GetCartCall.items(
                                            columnGetCartResponse.jsonBody,
                                          ))!
                                              .isNotEmpty) {
                                        return FutureBuilder<ApiCallResponse>(
                                          future: GetCartCall.call(),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 40.0,
                                                  ),
                                                ),
                                              );
                                            }
                                            final listViewGetCartResponse =
                                                snapshot.data!;

                                            return Builder(
                                              builder: (context) {
                                                final getCartAPI = getJsonField(
                                                  listViewGetCartResponse
                                                      .jsonBody,
                                                  r'''$.items''',
                                                ).toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: getCartAPI.length,
                                                  itemBuilder: (context,
                                                      getCartAPIIndex) {
                                                    final getCartAPIItem =
                                                        getCartAPI[
                                                            getCartAPIIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child:
                                                                          FlutterFlowExpandedImageView(
                                                                        image: Image
                                                                            .network(
                                                                          getJsonField(
                                                                            getCartAPIItem,
                                                                            r'''$.featured_image''',
                                                                          ).toString(),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                        allowRotation:
                                                                            false,
                                                                        tag:
                                                                            getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.featured_image''',
                                                                        ).toString(),
                                                                        useHeroAnimation:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Hero(
                                                                  tag:
                                                                      getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.featured_image''',
                                                                  ).toString(),
                                                                  transitionOnUserGestures:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      getJsonField(
                                                                        getCartAPIItem,
                                                                        r'''$.featured_image''',
                                                                      ).toString(),
                                                                      width:
                                                                          130.0,
                                                                      height:
                                                                          125.0,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          170.0,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Text(
                                                                        getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        maxLines:
                                                                            2,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              color: Colors.black,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          RichText(
                                                                        textScaler:
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'P/N :',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Open Sans',
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                getCartAPIItem,
                                                                                r'''$.meta.sku''',
                                                                              ).toString(),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          RichText(
                                                                        textScaler:
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'Price: £',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Open Sans',
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                getCartAPIItem,
                                                                                r'''$.price''',
                                                                              ).toString(),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      FlutterFlowIconButton(
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        20.0,
                                                                    buttonSize:
                                                                        35.0,
                                                                    fillColor:
                                                                        Color(
                                                                            0xFFEB445A),
                                                                    icon:
                                                                        FaIcon(
                                                                      FontAwesomeIcons
                                                                          .minus,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                    showLoadingIndicator:
                                                                        true,
                                                                    onPressed:
                                                                        () async {
                                                                      _model.minusQuantity =
                                                                          await UpdateInCartCall
                                                                              .call(
                                                                        itemkey:
                                                                            getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.item_key''',
                                                                        ).toString(),
                                                                        quantity: functions
                                                                            .itemDecreseQuantity(getJsonField(
                                                                              getCartAPIItem,
                                                                              r'''$.quantity.value''',
                                                                            ))
                                                                            .toString(),
                                                                      );

                                                                      if ((_model
                                                                              .minusQuantity
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Quantity update in cart',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        );
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                                Text(
                                                                  getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.quantity.value''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Open Sans',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      20.0,
                                                                  buttonSize:
                                                                      35.0,
                                                                  fillColor: Color(
                                                                      0xFF2DD36F),
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 20.0,
                                                                  ),
                                                                  showLoadingIndicator:
                                                                      true,
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isLoading =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.updateQuantity =
                                                                        await UpdateInCartCall
                                                                            .call(
                                                                      itemkey:
                                                                          getJsonField(
                                                                        getCartAPIItem,
                                                                        r'''$.item_key''',
                                                                      ).toString(),
                                                                      quantity: functions
                                                                          .itemQuantity(getJsonField(
                                                                            getCartAPIItem,
                                                                            r'''$.quantity.value''',
                                                                          ))
                                                                          .toString(),
                                                                    );

                                                                    if ((_model
                                                                            .updateQuantity
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      _model.isLoading =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Quantity update in cart',
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                        ),
                                                                      );
                                                                    }

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      _model.deleteCartItem =
                                                                          await DeleteItemInCartCall
                                                                              .call(
                                                                        itemkey:
                                                                            getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.item_key''',
                                                                        ).toString(),
                                                                        quantity:
                                                                            getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.quantity.value''',
                                                                        ),
                                                                      );

                                                                      if ((_model
                                                                              .deleteCartItem
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return WebViewAware(
                                                                              child: AlertDialog(
                                                                                title: Text('Cart details'),
                                                                                content: Text('Your cart item has been remove'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                    child: Text('Ok'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                        _model.getCartList =
                                                                            await GetCartCall.call();

                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return WebViewAware(
                                                                              child: AlertDialog(
                                                                                title: Text('Cart details'),
                                                                                content: Text('Your cart item  has been not remove'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                    child: Text('Ok'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    text:
                                                                        'Remove',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      size:
                                                                          15.0,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          30.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: Color(
                                                                          0xFFE00F0F),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFE00F0F),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        8.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 1.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 351.0, 0.0, 0.0),
                                                child: Text(
                                                  'No items in cart',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 19.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                      'CatalougePage');
                                                },
                                                text: 'Go to catalouge',
                                                options: FFButtonOptions(
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: Color(0xFF27AEDF),
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Open Sans',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                          ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (GetCartCall.items(
                                                columnGetCartResponse.jsonBody,
                                              ) !=
                                              null &&
                                          (GetCartCall.items(
                                            columnGetCartResponse.jsonBody,
                                          ))!
                                              .isNotEmpty) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 15.0, 0.0),
                                          child: RichText(
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Total :',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 22.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text: getJsonField(
                                                    columnGetCartResponse
                                                        .jsonBody,
                                                    r'''$.currency.currency_symbol''',
                                                  ).toString(),
                                                  style: GoogleFonts.getFont(
                                                    'Open Sans',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: GoogleFonts.getFont(
                                                    'Open Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: getJsonField(
                                                    cartPageGetCartResponse
                                                        .jsonBody,
                                                    r'''$.totals.total''',
                                                  ).toString(),
                                                  style: TextStyle(),
                                                )
                                              ],
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 25.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Wrap(
                                          spacing: 0.0,
                                          runSpacing: 0.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          runAlignment: WrapAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          children: [],
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (GetCartCall.items(
                                              columnGetCartResponse.jsonBody,
                                            ) !=
                                            null &&
                                        (GetCartCall.items(
                                          columnGetCartResponse.jsonBody,
                                        ))!
                                            .isNotEmpty) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 10.0, 15.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Wrap(
                                        spacing: 0.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [],
                                      );
                                    }
                                  },
                                ),
                                Builder(
                                  builder: (context) {
                                    if (GetCartCall.items(
                                              columnGetCartResponse.jsonBody,
                                            ) !=
                                            null &&
                                        (GetCartCall.items(
                                          columnGetCartResponse.jsonBody,
                                        ))!
                                            .isNotEmpty) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 15.0, 15.0, 20.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.orderCreate =
                                                await CreaterOrderCall.call(
                                              firstName: FFAppState().firstName,
                                              lastName: FFAppState().lastName,
                                              address1: GetCartCall.address1(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              address2: GetCartCall.address2(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              city: GetCartCall.city(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              state: GetCartCall.state(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              postcode: GetCartCall.postcode(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              country: GetCartCall.country(
                                                columnGetCartResponse.jsonBody,
                                              ),
                                              phone: FFAppState().telephone,
                                              lineItemsJson: _model.items,
                                              customerId: FFAppState()
                                                  .userId
                                                  .toString(),
                                            );

                                            if ((_model
                                                    .orderCreate?.succeeded ??
                                                true)) {
                                              context.pushNamed('OrderPage');

                                              _model.cartClear =
                                                  await CartClearCall.call();

                                              if ((_model
                                                      .cartClear?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Your cart is empty',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Not create order',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Create Order',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF27AEDF),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Color(0xFF27AEDF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Wrap(
                                        spacing: 0.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                 *//*

*/
/* Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: wrapWithModel(
                      model: _model.customBottomNavigationModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CustomBottomNavigationWidget(
                        selectedPage: 'catalouge',
                      ),
                    ),
                  ),*//*
*/
/*

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*//*

import 'package:aqaumatic_app/components/customDrawer.dart';
import 'package:aqaumatic_app/index.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
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
import 'cart_page_model.dart';
export 'cart_page_model.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({super.key});

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  late CartPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartPageModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.cartData = await GetCartCall.call();
      if ((_model.cartData?.succeeded ?? true)) {
        _model.items = functions.lineItems(getJsonField((_model.cartData?.jsonBody ?? ''), r'''$.items''',));
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
              borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 0.0,
              buttonSize: 46.0,
              fillColor: Color(0xFF27AEDF),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Color(0xFF27AEDF),
                borderRadius: 0.0,
                borderWidth: 0.0,
                buttonSize: 40.0,
                fillColor: Color(0xFF27AEDF),
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 24.0,
                ),
                onPressed: () async {
                  var confirmDialogResponse = await showDialog<bool>(
                    context: context,
                    builder: (alertDialogContext) {
                      return WebViewAware(
                        child: AlertDialog(
                          title: Text('Cart clear'),
                          content: Text('Are you sure you want to empty your cart?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext, false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext, true),
                              child: Text('Confirm'),
                            ),
                          ],
                        ),
                      );
                    },
                  ) ?? false;
                  if (confirmDialogResponse) {
                    _model.cartClearAPI = await CartClearCall.call();
                    if ((_model.cartClearAPI?.succeeded ?? true)) {
                      safeSetState(() {});
                    }
                  } else {
                    context.safePop();
                  }
                  safeSetState(() {});
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: FutureBuilder<ApiCallResponse>(
              future: GetCartCall.call(),
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
                final columnGetCartResponse = snapshot.data!;
                final getCartAPI = getJsonField(columnGetCartResponse.jsonBody, r'''$.items''',).toList();

                return  getCartAPI.isEmpty
                    ? Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Your cart is empty',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              fontSize: 18.0,
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
                           // onPressed: () => context.pushNamed('catalougePage'),
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
                    )
                    : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: getCartAPI.length,
                        itemBuilder: (context, index) {
                          final getCartAPIItem = getCartAPI[index];
                          return Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.0),
                                          child: Image.network(
                                            getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                            width: 130.0,
                                            height: 130.0,
                                            fit: BoxFit.cover,
                                          ),
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
                                              getJsonField(getCartAPIItem, r'''$.name''').toString(),
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'P/N: ',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: getJsonField(
                                                      getCartAPIItem,
                                                      r'''$.meta.sku''',
                                                    ).toString(),
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
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Price: £',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: getJsonField(
                                                        getCartAPIItem,
                                                        r'''$.price''',
                                                      ).toString(),
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
                                              child: Text(
                                                'Quantity: ${getJsonField(getCartAPIItem, r'''$.quantity.value''').toString()}',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
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
                                      //  color: Colors.green,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 20.0,
                                                buttonSize: 35.0,
                                                fillColor: Color(0xFFEB445A),
                                                icon: FaIcon(
                                                  FontAwesomeIcons.minus,
                                                  color:
                                                      FlutterFlowTheme.of(context).info,
                                                  size: 20.0,
                                                ),
                                                showLoadingIndicator: true,
                                                onPressed: () async {
                                                  _model.minusQuantity =
                                                      await UpdateInCartCall.call(
                                                    itemkey: getJsonField(
                                                      getCartAPIItem,
                                                      r'''$.item_key''',
                                                    ).toString(),
                                                    quantity: functions
                                                        .itemDecreseQuantity(
                                                            getJsonField(
                                                          getCartAPIItem,
                                                          r'''$.quantity.value''',
                                                        ))
                                                        .toString(),
                                                  );

                                                  if ((_model
                                                          .minusQuantity?.succeeded ??
                                                      true)) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Quantity update in cart',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(context)
                                                                .secondary,
                                                      ),
                                                    );
                                                  }

                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                            Text(
                                              getJsonField(
                                                getCartAPIItem,
                                                r'''$.quantity.value''',
                                              ).toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Open Sans',
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20.0,
                                              buttonSize: 35.0,
                                              fillColor: Color(0xFF2DD36F),
                                              icon: Icon(
                                                Icons.add,
                                                color:
                                                FlutterFlowTheme.of(context).info,
                                                size: 20.0,
                                              ),
                                              showLoadingIndicator: true,
                                              onPressed: () async {
                                                _model.isLoading = true;
                                                safeSetState(() {});
                                                _model.updateQuantity =
                                                await UpdateInCartCall.call(
                                                  itemkey: getJsonField(
                                                    getCartAPIItem,
                                                    r'''$.item_key''',
                                                  ).toString(),
                                                  quantity: functions
                                                      .itemQuantity(getJsonField(
                                                    getCartAPIItem,
                                                    r'''$.quantity.value''',
                                                  ))
                                                      .toString(),
                                                );

                                                if ((_model.updateQuantity?.succeeded ??
                                                    true)) {
                                                  _model.isLoading = false;
                                                  safeSetState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Quantity update in cart',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration:
                                                      Duration(milliseconds: 4000),
                                                      backgroundColor:
                                                      FlutterFlowTheme.of(context)
                                                          .secondary,
                                                    ),
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 15.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.deleteCartItem =
                                                await DeleteItemInCartCall.call(
                                              itemkey: getJsonField(
                                                getCartAPIItem,
                                                r'''$.item_key''',
                                              ).toString(),
                                              quantity: getJsonField(
                                                getCartAPIItem,
                                                r'''$.quantity.value''',
                                              ),
                                            );

                                            if ((_model.deleteCartItem?.succeeded ?? true)) {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: Text('Cart details'),
                                                      content: Text(
                                                          'Your cart item has been remove'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                              _model.getCartList =
                                                  await GetCartCall.call();

                                              safeSetState(() {});
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: Text('Cart details'),
                                                      content: Text(
                                                          'Your cart item  has been not remove'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Remove',
                                          icon: Icon(
                                            Icons.delete_outline,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 30.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFE00F0F),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Color(0xFFE00F0F),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          if (GetCartCall.items(
                            columnGetCartResponse.jsonBody,
                          ) !=
                              null &&
                              (GetCartCall.items(
                                columnGetCartResponse.jsonBody,
                              ))!
                                  .isNotEmpty) {
                            return Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 15.0, 0.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context)
                                    .textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total :',
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: getJsonField(
                                        columnGetCartResponse
                                            .jsonBody,
                                        r'''$.currency.currency_symbol''',
                                      ).toString(),
                                      style: GoogleFonts.getFont(
                                        'Open Sans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: GoogleFonts.getFont(
                                        'Open Sans',
                                        color: FlutterFlowTheme.of(
                                            context)
                                            .primaryText,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: getJsonField(
                                        columnGetCartResponse
                                            .jsonBody,
                                        r'''$.totals.total''',
                                      ).toString(),
                                      style: TextStyle(),
                                    )
                                  ],
                                  style:
                                  FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 25.0,
                                    letterSpacing: 0.0,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Wrap(
                              spacing: 0.0,
                              runSpacing: 0.0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment:
                              WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection:
                              VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: [],
                            );
                          }
                        },
                      ),
                    ),
                   Padding(
                     padding: EdgeInsets.all(5.0),
                     child: Divider(),
                   ),
                    Builder(
                      builder: (context) {
                        if (GetCartCall.items(columnGetCartResponse.jsonBody,) !=
                            null &&
                            (GetCartCall.items(
                              columnGetCartResponse.jsonBody,
                            ))!
                                .isNotEmpty) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 20.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.orderCreate =
                                await CreateOrderCall.call(

                                  firstName: FFAppState().firstName,
                                  lastName: FFAppState().lastName,
                                  address1: GetCartCall.address1(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  address2: GetCartCall.address2(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  city: GetCartCall.city(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  state: GetCartCall.state(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  postcode: GetCartCall.postcode(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  country: GetCartCall.country(
                                    columnGetCartResponse.jsonBody,
                                  ),
                                  phone: FFAppState().telephone,
                                  lineItemsJson: _model.items,
                                  customerId: FFAppState()
                                      .userId
                                      .toString(),
                                 
                                );

                                if ((_model
                                    .orderCreate?.succeeded ??
                                    true)) {
                                  context.pushNamed('OrderPage');

                                  _model.cartClear =
                                  await CartClearCall.call();

                                  if ((_model
                                      .cartClear?.succeeded ??
                                      true)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Your cart is empty',
                                          style: TextStyle(
                                            color:
                                            FlutterFlowTheme.of(
                                                context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(
                                            milliseconds: 4000),
                                        backgroundColor:
                                        FlutterFlowTheme.of(
                                            context)
                                            .secondary,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Not create order',
                                        style: TextStyle(
                                          color:
                                          FlutterFlowTheme.of(
                                              context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(
                                          milliseconds: 4000),
                                      backgroundColor:
                                      FlutterFlowTheme.of(
                                          context)
                                          .secondary,
                                    ),
                                  );
                                }

                                safeSetState(() {});
                              },
                              text: 'Create Order',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 40.0,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF27AEDF),
                                textStyle:
                                FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Color(0xFF27AEDF),
                                ),
                                borderRadius:
                                BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        } else {
                          return Wrap(
                            spacing: 0.0,
                            runSpacing: 0.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment:
                            WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection:
                            VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [],
                          );
                        }
                      },
                    ),
                    // Other widgets below the ListView can go here
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: 'catalouge',),
      ),
    );
  }
}

*/
/*import 'package:aqaumatic_app/components/customDrawer.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
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
import 'cart_page_model.dart';

export 'cart_page_model.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({super.key});

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  late CartPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartPageModel());

    // On page load action
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.cartData = await GetCartCall.call();
      if ((_model.cartData?.succeeded ?? true)) {
        _model.items = functions.lineItems(getJsonField(
          (_model.cartData?.jsonBody ?? ''),
          r'''$.items''',
        ));
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return *//*
*/
/*FutureBuilder<ApiCallResponse>(
      future: GetCartCall.call(),
      builder: (context, snapshot) {
        // Loading indicator
        if (!snapshot.hasData) {
          return Scaffold(
             backgroundColor: Colors.white,
            body: Center(
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
            bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: 'favourites'),
          );
        }

        final cartPageGetCartResponse = snapshot.data!;
        return*//*
*/
/* GestureDetector(
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
                  borderColor: Color(0xFF27AEDF),
                  borderRadius: 0.0,
                  borderWidth: 0.0,
                  buttonSize: 46.0,
                  fillColor: Color(0xFF27AEDF),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0xFF27AEDF),
                    borderRadius: 0.0,
                    borderWidth: 0.0,
                    buttonSize: 40.0,
                    fillColor: Color(0xFF27AEDF),
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              title: Text('Cart clear'),
                              content: Text('Are you sure you want to empty your cart?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            ),
                          );
                        },
                      ) ?? false;

                      if (confirmDialogResponse) {
                        _model.cartClearAPI = await CartClearCall.call();
                        if ((_model.cartClearAPI?.succeeded ?? true)) {
                          safeSetState(() {});
                        }
                      } else {
                        context.safePop();
                      }
                      safeSetState(() {});
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
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                child: FutureBuilder<ApiCallResponse>(
                  future: GetCartCall.call(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
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
                    }

                    final columnGetCartResponse = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                       // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              if (GetCartCall.items(columnGetCartResponse.jsonBody) != null &&
                                  (GetCartCall.items(columnGetCartResponse.jsonBody))!.isNotEmpty) {
                                *//*
*/
/* return FutureBuilder<ApiCallResponse>(
                                  future: GetCartCall.call(),
                                  builder: (context, snapshot) {
                                    // if (!snapshot.hasData) {
                                    //   return Center(
                                    //     child: SizedBox(
                                    //       width: 40.0,
                                    //       height: 40.0,
                                    //       child: SpinKitFadingCircle(
                    color: Color(0xFF27AEDF),(
                                    //         color: FlutterFlowTheme.of(context).primary,
                                    //         size: 40.0,
                                    //       ),
                                    //     ),
                                    //   );
                                    // }

                                   // final listViewGetCartResponse = snapshot.data!;*//*
*/
/*
                                    return Builder(
                                      builder: (context) {
                                        final getCartAPI = getJsonField(
                                          columnGetCartResponse.jsonBody,
                                          r'''$.items''',
                                        ).toList();

                                        print(getCartAPI);
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                               // padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                physics: AlwaysScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: getCartAPI.length,
                                                itemBuilder: (context, getCartAPIIndex) {
                                                  final getCartAPIItem = getCartAPI[getCartAPIIndex];
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
                                                    child: Column(
                                                     // mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                await Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType.fade,
                                                                    child: FlutterFlowExpandedImageView(
                                                                      image: Image.network(
                                                                        getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                                                        fit: BoxFit.contain,
                                                                      ),
                                                                      allowRotation: false,
                                                                      tag: getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                                                      useHeroAnimation: true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag: getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                                                transitionOnUserGestures: true,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                  child: Image.network(
                                                                    getJsonField(getCartAPIItem, r'''$.featured_image''').toString(),
                                                                    width: 130.0,
                                                                    height: 130.0,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Container(
                                                                      width: 170.0,
                                                                      decoration: BoxDecoration(),
                                                                      child: Text(
                                                                        getJsonField(
                                                                          getCartAPIItem,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        maxLines: 2,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Open Sans',
                                                                          color: Colors.black,
                                                                          fontSize: 16.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    RichText(
                                                                      textScaler:
                                                                      MediaQuery.of(context).textScaler,
                                                                      text:
                                                                      TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: 'P/N :',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Open Sans',
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text: getJsonField(
                                                                              getCartAPIItem,
                                                                              r'''$.meta.sku''',
                                                                            ).toString(),
                                                                            style: TextStyle(),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                          fontFamily: 'Open Sans',
                                                                          fontSize: 16.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                      child: RichText(
                                                                        textScaler:
                                                                        MediaQuery.of(context).textScaler,
                                                                        text:
                                                                        TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: 'Price: £',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                getCartAPIItem,
                                                                                r'''$.price''',
                                                                              ).toString(),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                            fontFamily: 'Open Sans',
                                                                            fontSize: 16.0,
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        getCartAPIItem,
                                                                        r'''$.quantity.value''',
                                                                      ).toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Open Sans',
                                                                        letterSpacing:
                                                                        0.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          *//*
*/
/*  IconButton(
                                                              icon: Icon(
                                                                Icons.delete_forever,
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                size: 24.0,
                                                              ),
                                                              onPressed: () async {
                                                                _model.deleteCartItem = await RemoveCartItemCall.call(
                                                                  itemId: getJsonField(getCartAPIItem, r'''$.id''').toString(),
                                                                );
                                                                if ((_model.removeItemResponse?.succeeded ?? true)) {
                                                                  safeSetState(() {});
                                                                }
                                                              },
                                                            ),*//*
*/
/*
                                                          ],
                                                        ),
                                                        Padding(padding:
                                                      EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Align(
                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                            child:
                                                            FlutterFlowIconButton(
                                                              borderColor: Colors.transparent,
                                                              borderRadius: 20.0,
                                                              buttonSize: 35.0,
                                                              fillColor: Color(0xFFEB445A),
                                                              icon: FaIcon(
                                                                FontAwesomeIcons.minus,
                                                                color: FlutterFlowTheme.of(context).info,
                                                                size: 20.0,
                                                              ),
                                                              showLoadingIndicator:
                                                              true,
                                                              onPressed:
                                                                  () async {
                                                                _model.minusQuantity =
                                                                await UpdateInCartCall
                                                                    .call(
                                                                  itemkey:
                                                                  getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.item_key''',
                                                                  ).toString(),
                                                                  quantity: functions
                                                                      .itemDecreseQuantity(getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.quantity.value''',
                                                                  ))
                                                                      .toString(),
                                                                );
                                              
                                                                if ((_model
                                                                    .minusQuantity
                                                                    ?.succeeded ??
                                                                    true)) {
                                                                  ScaffoldMessenger.of(context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                      Text(
                                                                        'Quantity update in cart',
                                                                        style: TextStyle(
                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration:
                                                                      Duration(milliseconds: 4000),
                                                                      backgroundColor:
                                                                      FlutterFlowTheme.of(context).secondary,
                                                                    ),
                                                                  );
                                                                }
                                              
                                                                safeSetState(
                                                                        () {});
                                                              },
                                                            ),
                                                          ),
                                                          Text(
                                                            getJsonField(
                                                              getCartAPIItem,
                                                              r'''$.quantity.value''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Open Sans',
                                                              letterSpacing:
                                                              0.0,
                                                            ),
                                                          ),
                                                          FlutterFlowIconButton(
                                                            borderColor:
                                                            Colors
                                                                .transparent,
                                                            borderRadius:
                                                            20.0,
                                                            buttonSize:
                                                            35.0,
                                                            fillColor: Color(
                                                                0xFF2DD36F),
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .info,
                                                              size: 20.0,
                                                            ),
                                                            showLoadingIndicator:
                                                            true,
                                                            onPressed:
                                                                () async {
                                                              _model.isLoading =
                                                              true;
                                                              safeSetState(
                                                                      () {});
                                                              _model.updateQuantity =
                                                              await UpdateInCartCall
                                                                  .call(
                                                                itemkey:
                                                                getJsonField(
                                                                  getCartAPIItem,
                                                                  r'''$.item_key''',
                                                                ).toString(),
                                                                quantity: functions
                                                                    .itemQuantity(getJsonField(
                                                                  getCartAPIItem,
                                                                  r'''$.quantity.value''',
                                                                ))
                                                                    .toString(),
                                                              );
                                              
                                                              if ((_model
                                                                  .updateQuantity
                                                                  ?.succeeded ??
                                                                  true)) {
                                                                _model.isLoading =
                                                                false;
                                                                safeSetState(
                                                                        () {});
                                                                ScaffoldMessenger.of(
                                                                    context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                    Text(
                                                                      'Quantity update in cart',
                                                                      style:
                                                                      TextStyle(
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                    duration:
                                                                    Duration(milliseconds: 4000),
                                                                    backgroundColor:
                                                                    FlutterFlowTheme.of(context).secondary,
                                                                  ),
                                                                );
                                                              }
                                              
                                                              safeSetState(
                                                                      () {});
                                                            },
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                15.0,
                                                                0.0),
                                                            child:
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                _model.deleteCartItem =
                                                                await DeleteItemInCartCall
                                                                    .call(
                                                                  itemkey:
                                                                  getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.item_key''',
                                                                  ).toString(),
                                                                  quantity:
                                                                  getJsonField(
                                                                    getCartAPIItem,
                                                                    r'''$.quantity.value''',
                                                                  ),
                                                                );
                                              
                                                                if ((_model
                                                                    .deleteCartItem
                                                                    ?.succeeded ??
                                                                    true)) {
                                                                  await showDialog(
                                                                    context:
                                                                    context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return WebViewAware(
                                                                        child: AlertDialog(
                                                                          title: Text('Cart details'),
                                                                          content: Text('Your cart item has been remove'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext),
                                                                              child: Text('Ok'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                  _model.getCartList =
                                                                  await GetCartCall.call();
                                              
                                                                  safeSetState(
                                                                          () {});
                                                                } else {
                                                                  await showDialog(
                                                                    context:
                                                                    context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return WebViewAware(
                                                                        child: AlertDialog(
                                                                          title: Text('Cart details'),
                                                                          content: Text('Your cart item  has been not remove'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext),
                                                                              child: Text('Ok'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                              
                                                                safeSetState(
                                                                        () {});
                                                              },
                                                              text:
                                                              'Remove',
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                size:
                                                                15.0,
                                                              ),
                                                              options:
                                                              FFButtonOptions(
                                                                height:
                                                                30.0,
                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                                color: Color(
                                                                    0xFFE00F0F),
                                                                textStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Open Sans',
                                                                  color:
                                                                  Colors.white,
                                                                  fontSize:
                                                                  13.0,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                ),
                                                                elevation:
                                                                0.0,
                                                                borderSide:
                                                                BorderSide(
                                                                  color: Color(
                                                                      0xFFE00F0F),
                                                                ),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    8.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),),
                                                        Divider(
                                                          height: 24.0,
                                                          thickness: 1.0,
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(1.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  if (GetCartCall.items(columnGetCartResponse.jsonBody) != null &&
                                                      (GetCartCall.items(columnGetCartResponse.jsonBody)!).isNotEmpty) {
                                                    return Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 15.0, 0.0),
                                                      child: RichText(
                                                        textScaler: MediaQuery.of(context).textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Total :',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Open Sans',
                                                                fontSize: 22.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(
                                                                columnGetCartResponse.jsonBody,
                                                                r'''$.currency.currency_symbol''',
                                                              ).toString(),
                                                              style: GoogleFonts.getFont(
                                                                'Open Sans',
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 22.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' ',
                                                              style: GoogleFonts.getFont(
                                                                'Open Sans',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 22.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: getJsonField(
                                                                columnGetCartResponse.jsonBody,
                                                                r'''$.totals.total''',
                                                              ).toString(),
                                                              style: TextStyle(),
                                                            ),
                                                          ],
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Open Sans',
                                                            fontSize: 25.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox(); // Return an empty box if no items
                                                  }
                                                },
                                              ),
                                            ),

                                            // Divider
                                            Builder(
                                              builder: (context) {
                                                if (GetCartCall.items(columnGetCartResponse.jsonBody) != null &&
                                                    (GetCartCall.items(columnGetCartResponse.jsonBody)!).isNotEmpty) {
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox(); // Return an empty box if no items
                                                }
                                              },
                                            ),

                                            // Create Order Button
                                            Builder(
                                              builder: (context) {
                                                if (GetCartCall.items(columnGetCartResponse.jsonBody) != null &&
                                                    (GetCartCall.items(columnGetCartResponse.jsonBody)!).isNotEmpty) {
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 20.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.orderCreate = await CreaterOrderCall.call(
                                                          firstName: FFAppState().firstName,
                                                          lastName: FFAppState().lastName,
                                                          address1: GetCartCall.address1(columnGetCartResponse.jsonBody),
                                                          address2: GetCartCall.address2(columnGetCartResponse.jsonBody),
                                                          city: GetCartCall.city(columnGetCartResponse.jsonBody),
                                                          state: GetCartCall.state(columnGetCartResponse.jsonBody),
                                                          postcode: GetCartCall.postcode(columnGetCartResponse.jsonBody),
                                                          country: GetCartCall.country(columnGetCartResponse.jsonBody),
                                                          phone: FFAppState().telephone,
                                                          lineItemsJson: _model.items,
                                                          customerId: FFAppState().userId.toString(),
                                                        );

                                                        if ((_model.orderCreate?.succeeded ?? true)) {
                                                          context.pushNamed('OrderPage');
                                                          _model.cartClear = await CartClearCall.call();

                                                          if ((_model.cartClear?.succeeded ?? true)) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Your cart is empty',
                                                                  style: TextStyle(
                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(milliseconds: 4000),
                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text('Not create order',
                                                                style: TextStyle(
                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(milliseconds: 4000),
                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                            ),
                                                          );
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      text: 'Create Order',
                                                      options: FFButtonOptions(
                                                        width: double.infinity,
                                                        height: 40.0,
                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                        color: Color(0xFF27AEDF),
                                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Open Sans',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Color(0xFF27AEDF),
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox(); // Return an empty box if no items
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                 *//*
*/
/* },
                                );*//*
*/
/*
                              } else {
                                return Center(
                                  child: Text(
                                    'Your cart is empty.',
                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationWidget(selectedPage: 'catalouge'),
          ),
        );
      // },
    // );
  }
}*/

