import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_app/auth/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import '../navigation/router.dart';
import '../navigation/slide.dart';
import '../state/ui/ui_provider.dart';
import '../static/loader.dart';
import '../static/shared.dart';
import '../theme/color_scheme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool isPasswordObsecured = true;
  bool _loginLoadingState = false;

  String? _emailProperty;
  String? _passwordProperty;
  String? _errorMessage;

  var authProvider;
  var uiProvider;

  @override
  void initState() {
    super.initState();
  }

// Methods
  void _togglePasswordObsecure() {
    setState(() {
      isPasswordObsecured = !isPasswordObsecured;
    });
  }

  void _submitLoginForm() {
    setState(() {
      _loginLoadingState = true;
      if (_loginFormKey.currentState!.validate()) {
        _loginFormKey.currentState!.save();
        _login();
      } else {
        _loginLoadingState = false;
      }
    });
  }

  void _login() async {
    try {
      var formDataa = {
        "password": _passwordProperty,
        "email": _emailProperty,
      };
      setState(() => {_loginLoadingState = true});
      var response = await Dio().post(
        '${SharedProperties.baseUrl}login_user',
        data: formDataa,
        queryParameters: formDataa,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
          headers: {
            HttpHeaders.acceptHeader: "application/json",
          },
        ),
      );

      final decodedResponse = response.data;
      if (decodedResponse['exception'] != null) {
        setState(() => {_errorMessage = "Server error occured try again later!", _loginLoadingState = false});
        return;
      }

      final checK = json.decode(decodedResponse['data']);

      if (checK['error'] == 'invalid_grant') {
        setState(() => {_errorMessage = "Invalid Login Credetials", _loginLoadingState = false});
        return;
      }

      if (decodedResponse['status'] == true) {
        setState(() => {_loginLoadingState = true});
        _showDefultMessage('Loged In successfully');
        authProvider.setAuthenticatedUser(decodedResponse);
        navigator(context, '/home');
      } else {
        setState(() => {_errorMessage = decodedResponse['message']['errors'], _loginLoadingState = false});
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        setState(() => {_loginLoadingState = false});
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        setState(() => {_loginLoadingState = false, _errorMessage = 'check your connection'});
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        setState(() => {_loginLoadingState = false, _errorMessage = 'unable to connect to the server'});
        return;
      }

      if (e.type == DioErrorType.unknown) {
        setState(() => {_errorMessage = 'An Error Occured Please try again'});
        return;
      }
      return;
    }
  }

  Widget _navigateToRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("No Account yet?", style: TextStyle(fontSize: 14.0)),
        smallHorinzontalSpacer(),
        InkWell(
          onHover: (value) => {},
          onTap: () => {Navigator.push(context, SlideRightRoute(page: const RegisterScreen()))},
          child: Text("Register", style: TextStyle(fontSize: 16.0, color: Theme.of(context).colorScheme.secondary)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    uiProvider = Provider.of<UiProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: MediaQuery.of(context).size.height,
                child: Container(width: double.infinity, decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: uiProvider.getThemeMode ? const AssetImage('assets/images/bg_dark.png') : const AssetImage('assets/images/bg_light.png')), color: Theme.of(context).colorScheme.background)),
              ),
              Consumer<UiProvider>(builder: (_, uiprovider, _2) {
                return Positioned(
                    child: Container(
                  padding: EdgeInsets.all(deviceHeight * 0.01),
                  width: deviceWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onHover: (value) {},
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(TablerIcons.language, color: Theme.of(context).colorScheme.secondary), Text("En", style: GoogleFonts.abel(fontSize: 12.0, fontWeight: FontWeight.normal, decoration: TextDecoration.none))],
                            ),
                          ),
                          smallHorinzontalSpacer(),
                          InkWell(
                              onHover: (value) {},
                              onTap: () {
                                uiprovider.toggleTheme();
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [uiprovider.getThemeMode ? Icon(TablerIcons.sun, color: Theme.of(context).colorScheme.onBackground) : Icon(TablerIcons.moon, color: Theme.of(context).colorScheme.onBackground)]))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 100.0,
                              width: 100.0,
                              margin: EdgeInsets.only(
                                left: deviceHeight * 0.005,
                              ),
                              decoration: BoxDecoration(image: uiProvider.getThemeMode ? const DecorationImage(image: AssetImage('assets/images/logo_white.png')) : const DecorationImage(image: AssetImage('assets/images/logo.png')))),
                          Column(
                            children: [
                              Text(
                                'LIDTA',
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30.0, fontWeight: FontWeight.bold, letterSpacing: 28.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (_errorMessage != null) Container(padding: const EdgeInsets.all(5.0), decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: const BorderRadius.all(Radius.circular(5.0))), child: Text(_errorMessage.toString(), style: GoogleFonts.abel(color: Theme.of(context).colorScheme.error, fontSize: 16.0, decoration: TextDecoration.none))),
                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: const Text('LOGIN', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 10.0)),
                                )
                              ],
                            ),
                            smallSpacer(),
                            _userEmailField(),
                            smallSpacer(),
                            _passwordFiled(),
                            smallSpacer(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [_navigateToRegister(context), !_loginLoadingState ? _loginButton() : const LoadingAnimation()]),
                            smallSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                forgotPasswordWidget(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              }),
            ],
          )),
        ],
      ),
    );
  }

  Widget forgotPasswordWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onHover: (value) {},
          onTap: () {},
          child: Text(
            'Forgot your password?',
            style: GoogleFonts.abel(color: Theme.of(context).colorScheme.secondary.withOpacity(0.75), fontSize: 16.0, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
          ),
        ),
      ],
    );
  }

  Widget _userEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
        onSaved: (val) => _emailProperty = val,
        validator: SharedProperties.validEmail,
        enableInteractiveSelection: false,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
        style: GoogleFonts.abel(fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
            labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
            labelText: "E-mail",
            suffixIcon: Icon(TablerIcons.mail, size: 25.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10))),
      ),
    );
  }

  Widget _passwordFiled() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
          onSaved: (val) => _passwordProperty = val,
          validator: SharedProperties.validPassword,
          obscureText: isPasswordObsecured,
          style: GoogleFonts.abel(fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
            labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
            labelText: 'Password',
            suffixIcon: InkWell(
              onTap: () {
                _togglePasswordObsecure();
              },
              onHover: (value) {},
              child: Icon(isPasswordObsecured ? TablerIcons.eye_off : TablerIcons.eye, size: 20.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10)),
            ),
          )),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onHover: (value) {},
      onTap: () {
        _submitLoginForm();
      },
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
          boxShadow: [
            BoxShadow(color: Theme.of(context).colorScheme.secondary.withOpacity(0.15), spreadRadius: 2, blurRadius: 20, offset: const Offset(0, 1)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              textDirection: TextDirection.rtl,
              style: GoogleFonts.abel(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background),
            ),
          ],
        ),
      ),
    );
  }

  void _showDefultMessage(String message) {
    if (!mounted) return;
    showFlash(
        context: context,
        duration: const Duration(seconds: 2),
        builder: (_, controller) {
          return Container(
            height: 50.0,
            margin: const EdgeInsets.all(10.0),
            child: Flash(
              backgroundColor: Colors.transparent,
              controller: controller,
              position: FlashPosition.top,
              behavior: FlashBehavior.floating,
              child: FlashBar(
                icon: Icon(TablerIcons.check, size: 24.0, color: Theme.of(context).colorScheme.primary),
                content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16.0)),
              ),
            ),
          );
        });
  }
}
