import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/login/login_bloc.dart';
import 'package:guardiansapp/repositories/authentication_repository.dart';

import '../MyColors.dart';
import '../helper_function.dart';
import 'Homepage.dart';

class LoginPage extends StatelessWidget {
  UserRepository userRepository = new UserRepository();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: LoginPageBody(),
      ),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  UserRepository userRepository = UserRepository();
  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.PrimaryColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoggedIn) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomePage(fromLogin: true, user: state.user)),
                (Route<dynamic> route) => false);
          }
        },
        child: Center(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Theme(
                data: new ThemeData(primaryColor: MyColor.SecondaryColor),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Container(
                            height: 200,
                            width: 200,
                            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Image.asset('asset/images/eschool.jpg'))),
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginFailure) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: MyColor.WarningDark),
                                color: MyColor.Warning,
                              ),
                              child: Center(
                                child: Text(
                                  '${state.error["message"]}',
                                  style:
                                      TextStyle(color: MyColor.SecondaryColor),
                                ),
                              ),
                            ));
                      }
                      return Container();
                    }),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                // height: 55,
                                decoration: BoxDecoration(
                                  color: MyColor.PrimaryColor,
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter a Phone Number';
                                    } else if (value.length != 10) {
                                      return 'Mobile Number must be of 10 digits';
                                    }
                                    return null;
                                  },
                                  style:
                                      TextStyle(color: MyColor.SecondaryColor),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColor.SecondaryColor)),
                                      labelStyle: TextStyle(
                                          color: MyColor.SecondaryColor),
                                      hintStyle: TextStyle(
                                          color: MyColor.SecondaryColor),
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone Number',
                                      hintText: '9812345678'),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter an password';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters!';
                                    }
                                    return null;
                                  },
                                  style:
                                      TextStyle(color: MyColor.SecondaryColor),
                                  obscureText: !_showPassword,
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColor.SecondaryColor)),
                                      labelStyle: TextStyle(
                                          color: MyColor.SecondaryColor),
                                      hintStyle: TextStyle(
                                          color: MyColor.SecondaryColor),
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'Password'),
                                ),
                              )),
                          FlatButton(
                            onPressed: () {
                              //TODO FORGOT PASSWORD SCREEN GOES HERE
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: MyColor.SecondaryColor, fontSize: 15),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: MyColor.SecondaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: FlatButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginButtonPressed(
                                          phone: emailController.text,
                                          password: passwordController.text));
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: MyColor.PrimaryColor, fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New User ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => {},
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
