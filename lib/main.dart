import 'dart:convert';

import 'package:arbpharm/ViewModels/Authentication/login_viewmodel.dart';
import 'package:arbpharm/ViewModels/Authentication/register_viewmodel.dart';
import 'package:arbpharm/ViewModels/Products/products_viewmodel.dart';
import 'package:arbpharm/ViewModels/demande/request_viewmodel.dart';
import 'package:arbpharm/ViewModels/home/home_viewmodel.dart';
import 'package:arbpharm/Views/Authentication/login/login_view.dart';
import 'package:arbpharm/Views/Authentication/login/password_forgotten_view.dart';
import 'package:arbpharm/Views/Authentication/login/reset_password_view.dart';
import 'package:arbpharm/Views/Authentication/register/add_profil_photo_view.dart';
import 'package:arbpharm/Views/home/generale_home_view.dart';
import 'package:arbpharm/Views/products/product_details_view.dart';
import 'package:arbpharm/Views/profile/profile%20settings/profile_settings.dart';
import 'package:arbpharm/Views/profile/request_history.dart';
import 'package:arbpharm/configs/generale_vars.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as dio;

import 'Models/profile/profile_model.dart';
import 'ViewModels/profile/profile_viewmodel.dart';
import 'Views/Authentication/register/category_view.dart';
import 'Views/Authentication/register/payement_view.dart';
import 'Views/Authentication/register/register_information_view.dart';
import 'Views/Authentication/register/register_view.dart';
import 'Views/profile/profile_view.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await isLogedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ProductsViewModel()),
        ChangeNotifierProvider(create: (context) => RequestViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> isLogedIn() async {
  var profileModel = ProfileModel();

  tokenConst = (await SharedPreferences.getInstance()).getString("token");

  if (tokenConst != null) {
    dio.Response? response = await profileModel.checkProfileActivation(
      token: tokenConst!,
    );

    if (response == null) {
      return;
    }

    if (response.statusCode == 200) {
      userConst.connected = true;
      userConst.isTypeActivated = response.data["is_active"];
    }
  }
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      color: seaBlue,
      navigatorKey: mainNavigatorKey,
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/register_information': (context) => RegisterInformationView(),
        '/payement_information': (context) => const PayementInformationView(),
        '/category_view': (context) => const CategoryView(),
        '/forgotten_password_view': (context) => ForgottenPasswordView(),
        '/reset_password_view': (context) => ResetPasswordView(),
        '/generale_home_view': (context) => const GeneraleHomeView(),
        '/add_photo_view': (context) => const AddProfilePicView(),
        '/product_details_view': (context) => const ProductDetailsView(),
        '/profile_settings': (context) => const ProfileSettings(),
        '/generale_home_view/requests_history': (context) =>
            const RequestHistory(),
        '/profile_view': (context) => const ProfileView(),
      },
      initialRoute: userConst.connected
          ? userConst.isTypeActivated
              ? '/generale_home_view'
              : '/profile_view'
          : '/login',
    );
  }
}
