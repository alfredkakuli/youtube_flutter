import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_app/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation/router.dart';
import '../navigation/slide.dart';
import '../state/ui/ui_provider.dart';
import '../static/loader.dart';
import '../static/shared.dart';
import '../theme/color_scheme.dart';
import '../views/pages/shared/widgets/custom_app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_form_field/phone_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  bool _toggleObsecureText = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  var authProvider;

  bool isPasswordObsecured = true;
  var _registerLoadingState = false;

  var _firstNameProperty = "Alfred";
  var _lastNameProperty = "kakuli";
  var _emailProperty = "me@me.com";
  var _phoneProperty = "+975555555555";
  var _passwordProperty = "12345678";

  String? _errorMessage;

  var uiProvider;

  File? _profileImageFile;
  String? _profileImagePath;

  _pickGalleryProfileImage() async {
    FilePickerResult? coverImage = await FilePicker.platform.pickFiles();
    if (coverImage != null) {
      File cover = File(coverImage.files.single.path!);
      PlatformFile fileProperties = coverImage.files.first;
      setState(() {
        _profileImageFile = cover;
        _profileImagePath = fileProperties.name;
      });
    } else {}
  }

  Future _pickCameraProfileImage() async {
    try {
      final profileImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (profileImage != null) {
        File profileImagePath = File(profileImage.path);
        _profileImageFile = profileImagePath;
        setState(() {
          _profileImageFile = profileImagePath;
        });
      } else {}
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changePasswordObsecure() {
    setState(() {
      _toggleObsecureText = !_toggleObsecureText;
    });
  }

  void _removeProfileImage() {
    setState(() {
      _profileImageFile = null;
    });
  }

  // Methods

  void _submitRegisterForm() {
    setState(() {
      _registerLoadingState = true;
    });
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      _userRegister(_profileImageFile);
    } else {
      setState(() {
        _registerLoadingState = false;
      });
    }
  }

  void _userRegister(imagePath) async {
    try {
      var formDataa = FormData.fromMap({
        "first_name": _firstNameProperty,
        "name": _firstNameProperty + _lastNameProperty,
        "last_name": _lastNameProperty,
        "password": _passwordProperty,
        "user_type": 3,
        "email": _emailProperty,
        "password_confirmation": _confirmPasswordController.text,
        "phone": _phoneProperty,
        "profile_image_url": _profileImageFile != null ? await MultipartFile.fromFile(imagePath.path, filename: imagePath.path.toString()) : 'test.png',
      });
      var response = await Dio().post(
        '${SharedProperties.baseUrl}register_user',
        data: formDataa,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
          headers: {
            HttpHeaders.acceptHeader: "json/application/json",
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );
      final decodedResponse = response.data;

      if (decodedResponse['exception'] != null) {
        debugPrint(decodedResponse['exception'].toString());
        setState(() => {_errorMessage = " Server error occured try again later!", _registerLoadingState = false});
        return;
      }

      if (decodedResponse['status'] == true) {
        setState(() => {_registerLoadingState = false});
        _showDefultMessage('Registered successfull');

        Navigator.push(context, SlideLeft(page: const LoginScreen()));
        // navigator(context, '/login_page');
        _storeUserInfo(decodedResponse);
      } else {
        setState(() => {_registerLoadingState = false, _errorMessage = decodedResponse['message']['errors'][0].toString()});
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        setState(() => {_registerLoadingState = false});
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        setState(() => {_registerLoadingState = false, _errorMessage = "Connection Timeout"});
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        setState(() => {_registerLoadingState = false, _errorMessage = "Server Timeout"});
        return;
      }

      if (e.type == DioErrorType.unknown) {
        setState(() => {_registerLoadingState = false, _errorMessage = "An Error Occured Try Again"});
        return;
      }
      setState(() => {_registerLoadingState = false});
      return;
    }
  }

  void _storeUserInfo(decodedResposnse) async {
    final accessToken = decodedResposnse['data']['original']['access_token'].toString();
    final userId = decodedResposnse['data']['original']['user']['id'].toString();
    final expiryTime = DateTime.now().add(Duration(minutes: int.parse(decodedResposnse['access_token_expires_in'].toString())));
    final userInfo = await SharedPreferences.getInstance();

    Map<String, dynamic> user = decodedResposnse['data']['original']['user'];
    user.putIfAbsent('access_token', () => accessToken);
    user.putIfAbsent('expiry_time', () => expiryTime);
    user.putIfAbsent('expires_in', () => decodedResposnse['access_token_expires_in']);
    user.putIfAbsent('customer_id', () => userId);
    userInfo.setString('user', json.encode(user));
  }

  @override
  void initState() {
    super.initState();
  }

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: uiProvider.getThemeMode ? const AssetImage('assets/images/bg_dark.png') : const AssetImage('assets/images/bg_light.png')),
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
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
                              children: [
                                Icon(
                                  TablerIcons.language,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                Text("En", style: GoogleFonts.abel(fontSize: 12.0, fontWeight: FontWeight.normal, decoration: TextDecoration.none))
                              ],
                            ),
                          ),
                          smallHorinzontalSpacer(),
                          InkWell(
                            onHover: (value) {},
                            onTap: () {
                              uiprovider.toggleTheme();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [uiprovider.getThemeMode ? Icon(TablerIcons.sun, color: Theme.of(context).colorScheme.onBackground) : Icon(TablerIcons.moon, color: Theme.of(context).colorScheme.onBackground)],
                            ),
                          ),
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
                              // top: deviceHeight * 0.18,
                              left: deviceHeight * 0.005,
                            ),
                            decoration: BoxDecoration(image: uiProvider.getThemeMode ? const DecorationImage(image: AssetImage('assets/images/logo_white.png')) : const DecorationImage(image: AssetImage('assets/images/logo.png'))),
                          ),
                          Column(
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
                            ],
                          ),
                        ],
                      ),
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                          child: Text(
                            _errorMessage.toString(),
                            style: GoogleFonts.abel(color: Theme.of(context).colorScheme.error, fontSize: 16.0, decoration: TextDecoration.none),
                          ),
                        ),
                      Form(
                        key: _registerFormKey,
                        child: Column(
                          children: [
                            Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(vertical: 20.0), child: const Text('REGISTER', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 10.0))),
                            smallSpacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: deviceHeight * 0.15,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(image: DecorationImage(image: _profileImageFile != null ? FileImage(_profileImageFile!) : FileImage(File('assets/images/logo.png')), fit: BoxFit.fill), color: Theme.of(context).colorScheme.surface, shape: BoxShape.circle),
                                          ),
                                          Positioned(
                                            left: 0.0,
                                            right: 0.0,
                                            bottom: 0.0,
                                            child: Container(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Expanded(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onHover: (value) {},
                                                      onTap: () => {_pickCameraProfileImage()},
                                                      child: Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                        padding: const EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, shape: BoxShape.circle),
                                                        child: Icon(TablerIcons.camera, size: 20.0, color: Theme.of(context).colorScheme.primary),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => {
                                                        _pickGalleryProfileImage(),
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        margin: const EdgeInsets.only(top: 20.0),
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, shape: BoxShape.circle),
                                                        child: Icon(TablerIcons.picture_in_picture, size: 20.0, color: Theme.of(context).colorScheme.primary),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onHover: (value) {},
                                                      onTap: () => {_removeProfileImage()},
                                                      child: Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                        padding: const EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, shape: BoxShape.circle),
                                                        child: Icon(TablerIcons.x, size: 20.0, color: Theme.of(context).colorScheme.error),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            smallSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Expanded(child: _firstName()), smallHorinzontalSpacer(), Expanded(child: _lastName())],
                            ),
                            smallSpacer(),
                            _emailFiled(),
                            smallSpacer(),
                            _phoneNumber(),
                            smallSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(child: _passwordFiled()),
                                smallHorinzontalSpacer(),
                                Expanded(
                                  child: _passwordConfirmFiled(),
                                ),
                              ],
                            ),
                            smallSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _navigateToLogin(context),
                                  ],
                                ),
                                !_registerLoadingState ? _registerButton() : const LoadingAnimation()
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

  Widget _navigateToLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Member Already?", style: TextStyle(fontSize: 14.0)),
        smallHorinzontalSpacer(),
        InkWell(
          onHover: (value) => {},
          onTap: () => {Navigator.push(context, SlideLeft(page: const LoginScreen()))},
          child: Text("Login", style: TextStyle(fontSize: 16.0, color: Theme.of(context).colorScheme.secondary)),
        ),
      ],
    );
  }

  Widget _registerButton() {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.secondary.withOpacity(0.15), spreadRadius: 2, blurRadius: 20, offset: const Offset(0, 1))],
      ),
      child: InkWell(
        onTap: () => {
          _submitRegisterForm(),
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Register",
              textDirection: TextDirection.rtl,
              style: GoogleFonts.abel(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background),
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstName() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
        onSaved: (val) => _firstNameProperty = val!,
        initialValue: _firstNameProperty,
        validator: SharedProperties.validUserName,
        enableInteractiveSelection: false,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
        style: GoogleFonts.abel(fontSize: 18.0, color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
          labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
          labelText: 'First Name',
          suffixIcon: InkWell(
            onTap: () {},
            onHover: (value) {},
            child: Icon(TablerIcons.user_circle, size: 20.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10)),
          ),
        ),
      ),
    );
  }

  Widget _lastName() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
        onSaved: (val) => _lastNameProperty = val!,
        initialValue: _lastNameProperty,
        validator: SharedProperties.validUserName,
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
          labelText: 'Last Name',
          suffixIcon: InkWell(
            onTap: () {},
            onHover: (value) {},
            child: Icon(TablerIcons.user_circle, size: 20.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10)),
          ),
        ),
      ),
    );
  }

  Widget _emailFiled() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
        onSaved: (val) => _emailProperty = val!,
        initialValue: _emailProperty,
        validator: SharedProperties.validEmail,
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
          labelText: 'E-mail',
          suffixIcon: InkWell(
            onTap: () {},
            onHover: (value) {},
            child: Icon(TablerIcons.mail, size: 20.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10)),
          ),
        ),
      ),
    );
  }

  Widget _passwordConfirmFiled() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
          controller: _confirmPasswordController,
          validator: (val) => val != _passwordController.text ? 'Must match Password' : null,
          obscureText: _toggleObsecureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10)),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.background.withOpacity(0.10))),
            labelStyle: GoogleFonts.abel(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.90)),
            labelText: 'Confirm Password',
            suffixIcon: GestureDetector(
              onTap: () => {_changePasswordObsecure()},
              child: Icon(isPasswordObsecured ? TablerIcons.eye_off : TablerIcons.eye, size: 20.0, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.10)),
            ),
          )),
    );
  }

  Widget _phoneNumber() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: PhoneFormField(
        initialValue: const PhoneNumber(isoCode: IsoCode.AE, nsn: "555555555"),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          labelText: "Phone Number",
        ),
        defaultCountry: IsoCode.AE,
        // selectorNavigator: ModalBottomSheetNavigator(100),
        validator: PhoneValidator.compose([PhoneValidator.required(errorText: "The field is required"), PhoneValidator.validMobile(errorText: "Provide Valid Phone No.")]),

        onSaved: (phoneNumber) => _phoneProperty = phoneNumber!.countryCode + phoneNumber.nsn, // default null
        onChanged: (phoneNumber) => _phoneProperty = phoneNumber!.countryCode + phoneNumber.nsn,
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

  Widget _passwordFiled() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.85),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.background.withOpacity(0.030), spreadRadius: 1.0, blurRadius: 1, offset: const Offset(1, 1))],
      ),
      child: TextFormField(
          controller: _passwordController,
          // initialValue: _passwordProperty,
          validator: SharedProperties.validPassword,
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

  void _showDefultMessage(String message) {
    if (!mounted) return;
    showFlash(
        context: context,
        duration: const Duration(seconds: 1),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.fixed,
            child: FlashBar(
              icon: const Icon(TablerIcons.check, size: 36.0),
              content: Text(message, style: const TextStyle(color: Colors.green)),
            ),
          );
        });
  }
}
