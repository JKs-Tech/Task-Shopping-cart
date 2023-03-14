import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_cart/bloc/login_bloc/login_bloc_event.dart';
import 'package:shoping_cart/bloc/login_bloc/login_bloc_state.dart';

class LoginBlock extends Bloc<LoginEvent, LoginState> {
  LoginBlock() : super(LoginInitialState()) {
    on<LoginPressEvent>((event, emit) async {
      try {
        var response = await http.post(
            Uri.parse("https://ecommerce.theprimoapp.com/api/login"),
            body: ({
              "email": event.email,
              "password": event.password,
              "device_token": event.diviceToken,
            }));
        if (response.statusCode == 200) {
          final tokenId = jsonDecode(response.body);
          // print("user ID" + tokenId["result"]['id'].toString());

          // here we store user id in sharedPrefrence
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString(
              "Login", tokenId["result"]['id'].toString());
          emit(LoginScussefulState());
        } else {
          Fluttertoast.showToast(msg: response.toString());
          emit(LoginErrorState());
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        emit(LoginErrorState());
      }
    });
    on<LoginErrorEvent>((event, emit) {
      emit(LoginErrorState());
    });
    on<LoginLoadingEvent>((event, emit) => {emit(LoginLoadingState())});
  }
}
