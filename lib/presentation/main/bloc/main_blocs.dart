import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocs extends Bloc<MainEvents,MainStates>{
  MainBlocs():super(InitMainStates()){
    on<ToggleThemeEvent>((event,emit){
     emit(MainStates(themeMode: event.themeMode));
    });


  }

}