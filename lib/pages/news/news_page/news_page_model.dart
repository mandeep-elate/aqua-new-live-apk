import '/components/custom_bottom_navigation_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'news_page_widget.dart' show NewsPageWidget;
import 'package:flutter/material.dart';

class NewsPageModel extends FlutterFlowModel<NewsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CustomBottomNavigation component.
  late CustomBottomNavigationModel customBottomNavigationModel;

  @override
  void initState(BuildContext context) {
    customBottomNavigationModel =
        createModel(context, () => CustomBottomNavigationModel());
  }

  @override
  void dispose() {
    customBottomNavigationModel.dispose();
  }
}
