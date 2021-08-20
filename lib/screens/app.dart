import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guardiansapp/blocs/master/master_bloc.dart';
import 'package:guardiansapp/repositories/authentication_repository.dart';
import 'package:guardiansapp/screens/Homepage.dart';
import 'package:guardiansapp/screens/login.dart';
import 'package:guardiansapp/screens/splashScreen.dart';

import '../MyColors.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserRepository userRepository;
  MyApp({Key? key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        title: 'GuardiansApp',
        theme: ThemeData(
          fontFamily: 'Proxima',
          primaryColor: MyColor.PrimaryColor,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<MasterBloc, MasterState>(
          builder: (context, state) {
            if (state is MasterInitial) {
              return SplashScreen();
            }
            if (state is MasterLoading) {
              return SplashScreen();
            }
            if (state is MasterLoaded) {
              if (state.loggedIn) {
                return HomePage(
                  fromLogin: false,
                );
              } else {
                return LoginPage();
              }
            }
            return Container();
          },
        ),
      ),
    ); // ));
  }
}
