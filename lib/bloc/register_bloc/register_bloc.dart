import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_cart/bloc/register_bloc/register_bloc_event.dart';
import 'package:shoping_cart/bloc/register_bloc/register_bloc_state.dart';

class RegisterBlock extends Bloc<RegisterEvent, RegisterState> {
  RegisterBlock() : super(RegisterInitialState()) {
    on<RegisterPressEvent>((event, emit) => {});
  }
}
