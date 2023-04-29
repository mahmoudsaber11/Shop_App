import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/shop_layout.dart';
import 'package:news_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:news_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/constant.dart';
import 'package:news_app/shared/cubits/cubit.dart';
import 'package:news_app/shared/cubits/states.dart';

import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'modules/shop_app/login/cubit/cubit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getBoolData(key: 'onBoarding');
  token = CacheHelper.getStringData(key: 'token');
  Widget screen;

  if (onBoarding != null) {
    if (token != null) {
      screen = const ShopLayout();
    } else {
      screen = ShopLoginScreen();
    }
  } else {
    screen = const OnBoardingScreen();
  }

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
  final Widget screen;
  const MyApp(this.screen, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(create: (context) => ShopLoginCubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: screen,
            );
          }),
    );
  }
}
