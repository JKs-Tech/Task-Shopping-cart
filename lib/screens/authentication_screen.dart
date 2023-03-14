import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shoping_cart/constraint.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shoping_cart/screens/homescreen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isObsecure = true;
  bool _isSignin = true;
  bool _isLoding = false;

  //controllers
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    surname.dispose();
    email.dispose();
    password.dispose();
    repassword.dispose();
  }

//From key

  final _fromfield = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _fromfield,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Text(
                    _isSignin ? "Sign in" : "Sign up",
                    style: GoogleFonts.alegreyaSans(
                        fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  _isSignin
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(),
                  _isSignin
                      ? Center(
                          child: Text(
                            "Become a member - don't miss out no deals, offers,disccount and bonus vouchers.",
                            style: GoogleFonts.baloo2(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 22,
                  ),
                  _isSignin
                      ? Column()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("*Name"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                  color: textFiledbgColor,
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    controller: name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Your Name";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontSize: 19),
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                  _isSignin
                      ? Column()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("*Surname"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                  color: textFiledbgColor,
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    controller: surname,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Your Surname";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontSize: 19),
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("*Email"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 16,
                        decoration: BoxDecoration(
                            color: textFiledbgColor,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: email,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return "Enter valid Email";
                                }
                                return null;
                              },
                              style: const TextStyle(fontSize: 19),
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("*Password"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 16,
                        decoration: BoxDecoration(
                            color: textFiledbgColor,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              obscureText: _isObsecure,
                              cursorColor: Colors.black,
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                              style: const TextStyle(fontSize: 19),
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                suffix: InkWell(
                                    onTap: () {
                                      _isObsecure = !_isObsecure;
                                      setState(() {});
                                    },
                                    child:
                                        Text(_isObsecure ? "SHOW" : "HIDDE")),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  _isSignin
                      ? Column()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("*Repet Password"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                  color: textFiledbgColor,
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    obscureText: _isObsecure,
                                    cursorColor: Colors.black,
                                    controller: repassword,
                                    validator: (value) {
                                      if (password == repassword) {
                                        return "Password dose't match";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontSize: 19),
                                    decoration: InputDecoration(
                                      suffix: InkWell(
                                          onTap: () {
                                            _isObsecure = !_isObsecure;
                                            setState(() {});
                                          },
                                          child: Text(
                                              _isObsecure ? "SHOW" : "HIDDE")),
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                  Center(
                    child: Text(
                      _isSignin ? "Forgotter password?" : "",
                      style: GoogleFonts.barlow(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  _isSignin
                      ? const SizedBox(
                          height: 35,
                        )
                      : const SizedBox(),
                  InkWell(
                    onTap: () async {
                      if (_fromfield.currentState!.validate()) {
                        // BlocProvider.of<LoginBlock>(context).add(LoginPressEvent(
                        //   email.text,
                        //   password.text,
                        //   "ssssssss",
                        // ));
                        _isSignin ? login() : signUp();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 16,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: _isLoding
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  _isSignin ? "Sign in" : "Sign up",
                                  style: GoogleFonts.anekLatin(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isSignin
                            ? "Don't have account?"
                            : "All ready have acoount?",
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSignin = !_isSignin;
                          });
                        },
                        child: Text(
                          _isSignin ? " SignUp now!" : " SignIn now!",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//Login functions
  void login() async {
    try {
      setState(() {
        _isLoding = true;
      });
      var response = await http.post(
          Uri.parse("https://ecommerce.theprimoapp.com/api/login"),
          body: ({
            "email": email.text,
            "password": password.text,
            "device_token": "sssssssss",
          }));
      if (response.statusCode == 200) {
        final tokenId = jsonDecode(response.body);
        // print("user ID" + tokenId["result"]['id'].toString());

        // here we store user id in sharedPrefrence
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
            "Login", tokenId["result"]['id'].toString());

        setState(() {
          _isLoding = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      } else {
        setState(() {
          _isLoding = false;
        });
        Fluttertoast.showToast(msg: response.toString());
      }
    } catch (e) {
      setState(() {
        _isLoding = false;
      });
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //Signup function
  void signUp() async {
    try {
      setState(() {
        _isLoding = true;
      });
      var response = await http.post(
          Uri.parse("https://ecommerce.theprimoapp.com/api/registration"),
          body: ({
            "first_name": name.text,
            "last_name": surname.text,
            "email": email.text,
            "password": password.text,
            "device_token": "sssssssss",
          }));
      if (response.statusCode == 200) {
        final tokenId = jsonDecode(response.body);
        // print("user ID" + tokenId["result"]['id'].toString());

        // here we store user id in sharedPrefrence
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
            "Login", tokenId["result"]['id'].toString());
        setState(() {
          _isLoding = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      } else {
        setState(() {
          _isLoding = false;
        });
        Fluttertoast.showToast(msg: response.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        _isLoding = false;
      });
    }
  }
}
