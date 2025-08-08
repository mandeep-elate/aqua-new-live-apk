/*
import '../favourite/favourite_page.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_bottom_navigation_model.dart';
export 'custom_bottom_navigation_model.dart';

class CustomBottomNavigationWidget extends StatefulWidget {
  const CustomBottomNavigationWidget({
    super.key,
    required this.selectedPage,
  });

  final String? selectedPage;

  @override
  State<CustomBottomNavigationWidget> createState() =>
      _CustomBottomNavigationWidgetState();
}

class _CustomBottomNavigationWidgetState
    extends State<CustomBottomNavigationWidget> {
  late CustomBottomNavigationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        //color: Color(0xFF019ADE),
        color: Color(0xFF43484B),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterFlowIconButton(
                 // borderColor: Color(0xFF019ADE),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  //fillColor: Color(0xFF019ADE),
                  icon: Icon(
                    Icons.menu_book,
                    color:  FlutterFlowTheme.of(context).secondaryBackground,
                    // color: widget!.selectedPage == 'catalouge'
                    //     ? FlutterFlowTheme.of(context).secondaryBackground
                    //     : Color(0xFF43484B),
                    size: 24.0,
                  ),
                  onPressed: () async {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed('CatalougePage');
                  },
                ),
                Text(
                  'Catalouge',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: widget!.selectedPage == 'catalouge'
                            ? FlutterFlowTheme.of(context).secondaryBackground
                            : Color(0xFF43484B),
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                 // borderColor: Color(0xFF019ADE),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  //fillColor: Color(0xFF019ADE),
                  icon: Icon(
                    Icons.star_rate,
                    color:  FlutterFlowTheme.of(context).secondaryBackground,
                    // color: widget!.selectedPage == 'favourites'
                    //     ? FlutterFlowTheme.of(context).secondaryBackground
                    //     : Color(0xFF43484B),
                    size: 24.0,
                  ),
                  onPressed: () async {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage(),));
                    //context.pushNamed('FavouritePage');
                  },
                ),
                Text(
                  'Favourites',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: widget.selectedPage == 'favourites'
                            ? FlutterFlowTheme.of(context).secondaryBackground
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                //  borderColor: Color(0xFF019ADE),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                 // fillColor: Color(0xFF019ADE),
                  icon: Icon(
                    Icons.menu_sharp,
                    color:  FlutterFlowTheme.of(context).secondaryBackground,
                    // color: widget!.selectedPage == 'orders'
                    //     ? FlutterFlowTheme.of(context).secondaryBackground
                    //     : Color(0xFF43484B),
                    size: 24.0,
                  ),
                  onPressed: () async {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed('OrderPage');
                  },
                ),
                Text(
                  'Orders',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: widget!.selectedPage == 'orders'
                            ? FlutterFlowTheme.of(context).secondaryBackground
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                 // borderColor: Color(0xFF019ADE),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                 // fillColor: Color(0xFF019ADE),
                  icon: Icon(
                    Icons.info_outline,
                    color:  FlutterFlowTheme.of(context).secondaryBackground,
                    // color: widget!.selectedPage == 'about'
                    //     ? FlutterFlowTheme.of(context).secondaryBackground
                    //     : Color(0xFF43484B),
                    size: 24.0,
                  ),
                  onPressed: () async {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed('AboutPage');
                  },
                ),
                Text(
                  'About',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: widget!.selectedPage == 'about'
                            ? FlutterFlowTheme.of(context).secondaryBackground
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 14,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'dart:io';

import '../favourite/favourite_page.dart';
import '../pages/catalouge/catalouge_page/catalouge_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'custom_bottom_navigation_model.dart';
export 'custom_bottom_navigation_model.dart';

class CustomBottomNavigationWidget extends StatefulWidget {
  const CustomBottomNavigationWidget({
    super.key,
    required this.selectedPage,
  });

  final String? selectedPage;

  @override
  State<CustomBottomNavigationWidget> createState() => _CustomBottomNavigationWidgetState();
}

class _CustomBottomNavigationWidgetState extends State<CustomBottomNavigationWidget> {
  late CustomBottomNavigationModel _model;
  EdgeInsetsDirectional? padding;

// Check the platform


  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    checkPadding();
    _model = createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void checkPadding(){
    if (Platform.isAndroid) {
      padding = EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 5.0) ; // Android padding
    } else if (Platform.isIOS) {
      padding = EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0); // iOS padding
    } else {
      padding = EdgeInsetsDirectional.all(10.0); // Default padding for other platforms
    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Color(0xFF43484B),
      ),
      child: Padding(
        //padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 5.0),
        padding: padding!,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildNavItem(
              context,
              icon: Icons.menu_book,
              label: 'Catalogue',
              selected: widget.selectedPage == 'catalouge',
              onTap: () {
                // if (Navigator.of(context).canPop()) {
                //   context.pop();
                // }
                //context.pushNamed('CataloguePage');
                Navigator.push(context, MaterialPageRoute(builder: (context) => CatalougePageWidget(),));
              },
            ),
            buildNavItem(
              context,
              icon: Icons.star_rate,
              label: 'Favourites',
              selected: widget.selectedPage == 'favourites',
              onTap: () {
                // if (Navigator.of(context).canPop()) {
                //   context.pop();
                // }
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
              },
            ),
            buildNavItem(
              context,
              icon: Icons.menu_sharp,
              label: 'Orders',
              selected: widget.selectedPage == 'orders',
              onTap: () {
                // if (Navigator.of(context).canPop()) {
                //   context.pop();
                // }
                context.pushNamed('OrderPage');
              },
            ),
            buildNavItem(
              context,
              icon: Icons.info_outline,
              label: 'About',
              selected: widget.selectedPage == 'about',
              onTap: () {
                // if (Navigator.of(context).canPop()) {
                //   context.pop();
                // }
                context.pushNamed('AboutPage');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, {
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF27AEDF) : Colors.transparent, // Blue container if selected
         // borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : FlutterFlowTheme.of(context).secondaryBackground,
              size: 24.0,
            ),
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Open Sans',
                color: selected ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).secondaryBackground,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



