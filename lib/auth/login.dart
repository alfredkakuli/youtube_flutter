import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import '../state/ui/ui_provider.dart';
import '../theme/color_scheme.dart';
import '../views/pages/shared/widgets/custom_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool _toggleObsecureText = true;

  var authProvider;

  List errors = [];
  var _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _loginLoadingState = false;
  String errorText = "";
  var _emailProperty;
  var _passwordProperty;
  bool isThisPageLoading = false;
  bool isPasswordObsecured = true;
  String _errorMessage = "";

  var uiProvider;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollOffset = _scrollController.offset;
      });
    super.initState();
  }

// Methods
  void _togglePasswordObsecure() {
    setState(() {
      isPasswordObsecured = !isPasswordObsecured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    uiProvider = Provider.of<UiProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(deviceWidth, 50.0),
        child: CustomAppBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        // physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: MediaQuery.of(context).size.height,

                // decoration: backgroundGradient,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [],
                    // gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.background]),
                    // image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/bg_b.png')),
                    image: DecorationImage(
                      // opacity: 0.75,
                      fit: BoxFit.cover,
                      image: uiProvider.getThemeMode
                          ? const AssetImage(
                              'assets/images/bg_dark.png',
                            )
                          : const AssetImage(
                              'assets/images/bg_light.png',
                            ),
                    ),
                    color: Theme.of(context).colorScheme.background,
                  ),

                  //     BoxDecoration(
                  //   color: secondaryLightColor,
                  //   boxShadow: [
                  //     customBoxShadow,
                  //   ],
                  // ),
                ),
              ),
              Consumer<UiProvider>(builder: (_, uiprovider, _2) {
                // var dynacHeight = uiProvider.getResponsive['InnerHeight'];
                // var dynacWidth = uiProvider.getResponsive['Innerwidth'];
                // var currentDeviceWidth = uiProvider.getResponsive['screenSize'];
                // var currentDeviceHeight = uiProvider.getResponsive['screenSizeHeight'];
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
                              children: [
                                Icon(
                                  TablerIcons.language,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                Text(
                                  "En",
                                  style: GoogleFonts.abel(fontSize: 12.0, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
                                )
                              ],
                            ),
                          ),
                          smallHorinzontalSpacer(),
                          smallHorinzontalSpacer(),
                          smallHorinzontalSpacer(),
                          InkWell(
                            onHover: (value) {},
                            onTap: () {
                              uiprovider.toggleTheme();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                uiprovider.getThemeMode
                                    ? Icon(
                                        TablerIcons.sun,
                                        color: Theme.of(context).colorScheme.onBackground,
                                      )
                                    : Icon(
                                        TablerIcons.moon,
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // largeSpacer(),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100.0,
                              width: 100.0,
                              margin: EdgeInsets.only(
                                // top: deviceHeight * 0.18,
                                left: deviceHeight * 0.005,
                              ),
                              decoration: BoxDecoration(image: uiProvider.getThemeMode ? DecorationImage(image: AssetImage('assets/images/logo_white.png')) : DecorationImage(image: AssetImage('assets/images/logo.png'))),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    // top: deviceHeight * 0.20,
                                    ),
                                child: Column(
                                  children: [
                                    Text(
                                      'LIDTA',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 28.0,
                                      ),
                                    ),
                                    // Text(
                                    //   'SOLUTIONS',
                                    //   style: TextStyle(
                                    //     color: allPrimary,
                                    //     fontSize: 30.0,
                                    //     fontWeight: FontWeight.bold,
                                    //     letterSpacing: 10.0,
                                    //   ),
                                    // ),
                                  ],
                                )),
                          ],
                        ),
                      ),

                      if (_errorMessage != "")
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                          child: Text(
                            _errorMessage,
                            style: GoogleFonts.abel(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),

                      Container(
                        // margin: EdgeInsets.all(deviceHeight * 0.015),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 10.0,
                                  ),
                                ),
                              ),
                              smallSpacer(),
                              _userNameField(),
                              smallSpacer(),
                              _passwordFiled(),
                              smallSpacer(),
                              forgotPasswordWidget(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _loginButton(),
                                  // !isThisPageLoading ? _loginButton() : LoadingAnimation(),
                                ],
                              ),
                              largeSpacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // _navigateToRegister(context),
                                  // navigateToRegister(context, '/register_page'),
                                ],
                              ),
                            ],
                          ),
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

  Widget _navigateToRegister(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   // context,
        //   // SlideRightRoute(page: RegisterScreen()),
        // )
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Dont have an Account yet? Register",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
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

  Widget _largeLogin(_screeWidth, _screeHeight) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: _screeHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: _screeWidth * 0.65,
                        child: Column(
                          children: [],
                        )),
                    Container(
                      width: _screeWidth * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _loginText(_screeWidth, _screeHeight, context),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: _screeWidth * 0.30,
                              margin: EdgeInsets.only(top: _screeHeight * 0.025),
                              padding: EdgeInsets.all(_screeHeight * 0.035),
                              // decoration: lightDecoration(),
                              child: Column(
                                children: [
                                  _userNameField(),
                                  smallSpacer(),
                                  _passwordFiled(),
                                  smallSpacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _loginButton(),
                                      // LoadingAnimation(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onHover: (value) {},
                                        onTap: () {},
                                        child: Text(
                                          'Forgot your password?',
                                          style: GoogleFonts.abel(fontSize: 16.0, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loginText(_screeWidth, _screeHeight, context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: _screeHeight * 0.0025),
        padding: EdgeInsets.all(_screeHeight * 0.0015),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "SOLUTIONS LOGIN".toUpperCase(),
                style: GoogleFonts.abel(color: Theme.of(context).colorScheme.secondary, fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0, decoration: TextDecoration.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userNameField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background.withOpacity(0.030),
            spreadRadius: 1.0,
            blurRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          )
        ],
      ),
      child: TextFormField(
        onSaved: (val) => _emailProperty = val.toString(),
        validator: (val) {
          // if (!val.toString().isValidName) return 'Please Provide a Valid Username';
        },
        enableInteractiveSelection: false,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
        style: GoogleFonts.abel(fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10)),
            ),
            labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
            labelText: "Username",
            suffixIcon: Icon(
              TablerIcons.user,
              size: 25.0,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10),
            )),
      ),
    );
  }

  Widget _passwordFiled() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background.withOpacity(0.030),
            spreadRadius: 1.0,
            blurRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          )
        ],
      ),
      child: TextFormField(
          // controller: _passwordController,
          validator: (value) {
            // if (!value.toString().isValidName) {
            //   return "Please Provide a valid Password";
            // }
          },
          obscureText: isPasswordObsecured,
          onSaved: (val) => _passwordProperty = val.toString(),
          style: GoogleFonts.abel(fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10)),
            ),
            labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
            labelText: 'Password',
            // prefixIcon: Icon(
            //   Icons.lock,
            //   size: 20.0,
            //   color: primaryColor,
            // ),
            suffixIcon: InkWell(
              onTap: () {
                _togglePasswordObsecure();
              },
              onHover: (value) {},
              child: Icon(
                isPasswordObsecured ? TablerIcons.eye_off : TablerIcons.eye,
                size: 20.0,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10),
              ),
            ),
          )),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onHover: (value) {},
      onTap: () {
        // _validateLoginForm();
      },
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              textDirection: TextDirection.rtl,
              style: GoogleFonts.abel(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            // Icon(
            //   Icons.arrow_forward,
            //   color: white,
            //   size: 14.0,
            // )
          ],
        ),
      ),
    );
  }

  void _showMessage(
    String message,
    bool color,
    BuildContext context, {
    bool persistent = true,
    EdgeInsets margin = EdgeInsets.zero,
  }) {
    showFlash(
      context: context,
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: margin,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          borderRadius: BorderRadius.circular(8.0),
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: color ? [Colors.pink, Colors.black87] : [Colors.green, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.transparent),
            child: FlashBar(
              // title: Text('Error'),
              content: Text(message),
              indicatorColor: Colors.red,
              icon: Icon(Icons.info_outline),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Close'),
              ),
              // actions: <Widget>[
              //   TextButton(
              //       onPressed: () => controller.dismiss('Yes, I do!'),
              //       child: Text('YES')),
              //   TextButton(
              //       onPressed: () => controller.dismiss('No, I do not!'),
              //       child: Text('NO')),
              // ],
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showDefultMessage(_.toString());
      }
    });
  }

  void _showDefultMessage(String message) {
    if (!mounted) return;
    showFlash(
        context: context,
        duration: Duration(seconds: 1),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.fixed,
            child: FlashBar(
              icon: Icon(
                Icons.check,
                size: 36.0,
              ),
              content: Text(
                message,
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        });
  }
}
