import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'count_controller_component_model.dart';
export 'count_controller_component_model.dart';

class CountControllerComponentWidget extends StatefulWidget {
  const CountControllerComponentWidget({
    super.key,
    required this.countValue,
  });

  final int? countValue;

  @override
  State<CountControllerComponentWidget> createState() =>
      _CountControllerComponentWidgetState();
}

class _CountControllerComponentWidgetState
    extends State<CountControllerComponentWidget> {
  late CountControllerComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountControllerComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
       // color: FlutterFlowTheme.of(context).secondaryBackground,
       // color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(0.0),
        shape: BoxShape.rectangle,
        border: Border.all(
         //color: FlutterFlowTheme.of(context).primaryBackground,
         color: Colors.white,
          width: 0.0,
        ),
      ),
      child: FlutterFlowCountController(
        decrementIconBuilder: (enabled) => FaIcon(
          FontAwesomeIcons.minusCircle,
          color: enabled ? Color(0xFFEB445A) : Color(0xFFEB445A),
          size: 25.0,
        ),
        incrementIconBuilder: (enabled) => FaIcon(
          FontAwesomeIcons.plusCircle,
          color: enabled ? Color(0xFF2DD36F) : Color(0xFFEB445A),
          size: 25.0,
        ),
        countBuilder: (count) => Text(
          count.toString(),
          style: FlutterFlowTheme.of(context).titleLarge.override(
                fontFamily: 'Open Sans',
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        count: _model.countControllerValue ??= 1,
        updateCount: (count) async {
          safeSetState(() => _model.countControllerValue = count);
          FFAppState().cartCount = _model.countControllerValue!;
          safeSetState(() {});
        },
        stepSize: 1,
        minimum: 1,
        contentPadding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 3.0, 0.0),
      ),
    );
  }
}
