import 'package:flutter/gestures.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailTextFieldTextController ??= TextEditingController();
    _model.emailTextFieldFocusNode ??= FocusNode();

    _model.passwordTextFieldTextController ??= TextEditingController();
    _model.passwordTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 403.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Group.png',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: TextFormField(
                    controller: _model.emailTextFieldTextController,
                    focusNode: _model.emailTextFieldFocusNode,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      //isDense: true,
                      alignLabelWithHint: false,
                      hintText: 'Enter your Email',
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Open Sans',
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDEDEDE),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDEDEDE),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      // contentPadding:
                      //     EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 25.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Open Sans',
                          letterSpacing: 0.0,
                        ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    validator: _model.emailTextFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Open Sans',
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: TextFormField(
                      controller: _model.passwordTextFieldTextController,
                      focusNode: _model.passwordTextFieldFocusNode,
                      autofocus: false,
                      obscureText: !_model.passwordTextFieldVisibility,
                      decoration: InputDecoration(
                        // isDense: true,
                        hintText: 'Enter your password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFDEDEDE),
                            width:1.0,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFDEDEDE),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        // contentPadding: EdgeInsetsDirectional.fromSTEB(
                        //     5.0, 0.0, 0.0, 0.0),
                        suffixIcon: InkWell(
                          onTap: () => safeSetState(
                            () => _model.passwordTextFieldVisibility =
                                !_model.passwordTextFieldVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            _model.passwordTextFieldVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 15.0,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.0,
                          ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: _model
                          .passwordTextFieldTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),



                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.loginAPIResult = await LoginCall.call(
                        username: _model.emailTextFieldTextController.text,
                        password: _model.passwordTextFieldTextController.text,
                      );

                      if ((_model.loginAPIResult?.succeeded ?? true)) {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signIn(
                          authenticationToken: UserStruct.maybeFromMap((_model.loginAPIResult?.jsonBody ?? ''))?.token,
                          authUid: UserStruct.maybeFromMap((_model.loginAPIResult?.jsonBody ?? ''))?.id.toString(),
                          userData: UserStruct.maybeFromMap((_model.loginAPIResult?.jsonBody ?? '')),
                        );
                        FFAppState().userId = LoginCall.id(
                          (_model.loginAPIResult?.jsonBody ?? ''),
                        )!;
                        FFAppState().firstName = LoginCall.firstName(
                          (_model.loginAPIResult?.jsonBody ?? ''),
                        )!;
                        FFAppState().lastName = LoginCall.lastName(
                          (_model.loginAPIResult?.jsonBody ?? ''),
                        )!;
                        FFAppState().email = LoginCall.email(
                          (_model.loginAPIResult?.jsonBody ?? ''),
                        )!;
                        FFAppState().token = LoginCall.token(
                          (_model.loginAPIResult?.jsonBody ?? ''),
                        )!;
                        // FFAppState().wishlistKey = LoginCall.shareKey(
                        //   (_model.loginAPIResult?.jsonBody ?? ''),
                        // )!;
                        // FFAppState().wishlistId = LoginCall.wishlistId(
                        //   (_model.loginAPIResult?.jsonBody ?? ''),
                        // )!;
                        safeSetState(() {});
                        context.pushNamedAuth(
                            'CatalougePage', context.mounted);
                        /*if ((FFAppState().wishlistKey == null || FFAppState().wishlistKey == '') &&
                            (FFAppState().wishlistId == null)) {_model.createWishlistAPICopy =
                              await CreateWishlistCall.call(
                            title: LoginCall.firstName((_model.loginAPIResult?.jsonBody ?? ''),),
                            userId: LoginCall.id((_model.loginAPIResult?.jsonBody ?? ''),),
                          );

                          if ((_model.createWishlistAPICopy?.succeeded ?? true)) {
                            FFAppState().wishlistKey = CreateWishlistCall.shareKey(
                              (_model.createWishlistAPICopy?.jsonBody ?? ''),)!;
                            FFAppState().wishlistId = CreateWishlistCall.id(
                              (_model.createWishlistAPICopy?.jsonBody ?? ''),)!;
                            safeSetState(() {});
                            context.pushNamedAuth(
                                'CatalougePage', context.mounted);
                          }
                        } else {
                          context.pushNamedAuth(
                              'CatalougePage', context.mounted);
                        }*/
                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              getJsonField(
                                (_model.loginAPIResult?.jsonBody ?? ''),
                                r'''$.message''',
                              ).toString(),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                            FlutterFlowTheme.of(context)
                                .secondary,
                          ),
                        );

                      }

                      safeSetState(() {});
                    },
                    text: 'LOG IN',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await launchURL(
                          'https://aquamaticwp.elate-ecommerce.com/');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        border: Border.all(
                          color: Color(0xFF1076BA),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'REGISTER INTEREST',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF1076BA),
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/Group_20.png',
                                width: 20.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center, // Ensures the text is centered
                    text: TextSpan(
                      text: 'Our app is updated! ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Reset your password',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            color: Colors.blue, // Hyperlink color
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold, // Bold text
                            decoration: TextDecoration.underline, // Hyperlink underline
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // Add hyperlink logic here
                              print('Reset your password clicked!');
                              // Example: Navigate to the reset password page
                              await launchURL(
                                  'https://www.aquamatic.co.uk/wp-login.php?action=lostpassword');
                            },
                        ),
                        TextSpan(
                          text: ' to proceed, or log in if you’ve already done so.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
}
