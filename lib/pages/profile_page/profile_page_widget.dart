import 'dart:convert';

import '../../components/customDrawer.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';
import 'package:http/http.dart' as http;

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

    _model.oldPasswordTextController ??= TextEditingController();
    _model.oldPasswordFocusNode ??= FocusNode();

    _model.newPasswordTextController ??= TextEditingController();
    _model.newPasswordFocusNode ??= FocusNode();
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
             // borderColor: Color(0xFF27AEDF),
              borderRadius: 0.0,
              borderWidth: 1.0,
              buttonSize: 46.0,
             // fillColor: Color(0xFF27AEDF),
              icon: Icon(
                Icons.menu_sharp,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24.0,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),

          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Profile',
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
        body: Form(
          key: _formKey,
          child: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 20.0),
                child: FutureBuilder<ApiCallResponse>(
                  future: GetUserProfileCall.call(
                    userId: FFAppState().userId,

                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
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
                    final columnGetUserProfileResponse = snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Profile Details',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'First Name',
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                columnGetUserProfileResponse.jsonBody,
                                r'''$.first_name''',
                              ).toString(),
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
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Last Name',
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                columnGetUserProfileResponse.jsonBody,
                                r'''$.last_name''',
                              ).toString(),
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
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Telephone',
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                columnGetUserProfileResponse.jsonBody,
                                r'''$.billing.phone''',
                              ).toString(),
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
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Email Address',
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                columnGetUserProfileResponse.jsonBody,
                                r'''$.email''',
                              ).toString(),
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
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Change Password',
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF43484B),
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                            ),
                          ),
                          TextFormField(
                            controller: _model.oldPasswordTextController,
                            focusNode: _model.oldPasswordFocusNode,
                            //autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              hintText: 'New Password',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color:
                                        FlutterFlowTheme.of(context).secondaryText,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryText,
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
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter to new password';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.newPasswordTextController,
                              focusNode: _model.newPasswordFocusNode,
                             // autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                hintText: 'Confirm Password',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
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
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    letterSpacing: 0.0,
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter to confirm password';
                                }
                                return null;
                              },
                            ),
                          ),
                          /*Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 35.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.changePasswordAPI = await ChangePasswordCall.call(
                                    userId: FFAppState().userId,
                                    password: _model.oldPasswordTextController.text,
                                    newPassword: _model.newPasswordTextController.text,
                                  );

                                  if ((_model.changePasswordAPI?.succeeded ??
                                      true)) {
                                    GoRouter.of(context).prepareAuthEvent();
                                    await authManager.signOut();
                                    GoRouter.of(context).clearRedirectLocation();

                                    context.pushNamedAuth(
                                        'LoginPage', context.mounted);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          getJsonField(
                                            (_model.changePasswordAPI?.jsonBody ??
                                                ''),
                                            r'''$.msg''',
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
                                text: 'Update Password',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFF27AEDF),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                          ),*/
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                /*onPressed: () async {
                                  // Call the API to change the password
                                  _model.changePasswordAPI = await ChangePasswordCall.call(
                                    userId: FFAppState().userId,
                                    password: _model.oldPasswordTextController.text,
                                    newPassword: _model.newPasswordTextController.text,

                                  );

                                  // Print the full API response for debugging
                                  print('API Response: ${_model.changePasswordAPI?.jsonBody}');

                                  // Check if the API call was successful
                                  if (_model.changePasswordAPI?.succeeded ?? false) {
                                    // Print success message from API response
                                    print('Success Message: ${getJsonField(_model.changePasswordAPI?.jsonBody ?? '', r'''$.data''')}');

                                    // Clear the text fields after success
                                    _model.oldPasswordTextController!.clear();
                                    _model.newPasswordTextController!.clear();

                                    // Show success message in a SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          getJsonField(
                                            (_model.changePasswordAPI?.jsonBody ?? ''),
                                            r'''$.data''',
                                          ).toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: FlutterFlowTheme.of(context).success, // Success color
                                      ),
                                    );
                                  } else {
                                    // Print error message from API response
                                    print('Error Message: ${getJsonField(_model.changePasswordAPI?.jsonBody ?? '', r'''$.data''')}');

                                    // Show error message in a SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          getJsonField(
                                            (_model.changePasswordAPI?.jsonBody ?? ''),
                                            r'''$.data''',
                                          ).toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: FlutterFlowTheme.of(context).secondary, // Error color
                                      ),
                                    );
                                  }

                                  // Update the UI
                                  safeSetState(() {});
                                },*/
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Check if old password and new password are the same
                                    if (_model.oldPasswordTextController.text == _model.newPasswordTextController.text) {
                                      // Show error message if passwords match

                                      try {
                                        // Proceed with the API call
                                        await changePassword(
                                          userId: FFAppState().userId,
                                          password: _model.oldPasswordTextController.text,
                                          newPassword: _model.newPasswordTextController.text,
                                        );

                                        // Show success message in a SnackBar
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //       'Password changed successfully!',
                                        //       style: TextStyle(
                                        //         color: FlutterFlowTheme.of(context).primaryText,
                                        //       ),
                                        //     ),
                                        //     duration: Duration(milliseconds: 4000),
                                        //     backgroundColor: FlutterFlowTheme.of(context).secondary, // Success color
                                        //   ),
                                        // );

                                        // Clear the text fields after success
                                        _model.oldPasswordTextController!.clear();
                                        _model.newPasswordTextController!.clear();
                                      } catch (e) {
                                        // Show error message in a SnackBar in case of failure
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to change password: $e',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Colors.red, // Error color
                                          ),
                                        );
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Confirm password cannot be the same as the new password!',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryText,
                                            ),
                                          ),
                                          duration: Duration(milliseconds: 4000),
                                          backgroundColor: Colors.red, // Error color
                                        ),
                                      );
                                      return; // Stop further execution
                                    }

                                  }
                                },



                                text: 'Update Password',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFF27AEDF),
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                          ),


                        ].addToEnd(SizedBox(height: 50.0)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> changePassword({
    required int userId,
    required String password,
    required String newPassword,
  }) async {
    // The API URL
    final String url = '${FFAppConstants.baseUrl}wp-json/custom/v1/change-password';

    // Form data to be sent in the request
    var requestData = {
      'user_id': userId.toString(), // Ensure the user_id is sent as a string
      'password': password,
      'new_password': newPassword,
    };

    try {
      // Making the POST request
      final response = await http.post(
        Uri.parse(url),
        body: requestData, // Form data is automatically encoded
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        // Check if the API actually indicates success
        if (responseData['success'] == true) {
          print('Password changed successfully: ${responseData['data']}');

          // Show success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password changed successfully!',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary, // Success color
            ),
          );

          // Clear text fields on success
          _model.oldPasswordTextController!.clear();
          _model.newPasswordTextController!.clear();
        } else {
          // Handle API-reported failure
          print('Failed to change password: ${responseData['data']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to change password: ${responseData['data']}',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: Colors.red, // Error color
            ),
          );
        }
      } else {
        // Handle HTTP errors (non-200 status codes)
        print('Failed to change password. HTTP Status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to change password. Please try again.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Colors.red, // Error color
          ),
        );
      }

    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
