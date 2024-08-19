import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_events.dart';
import 'main_states.dart';

class MainBlocs extends Bloc<MainEvents,MainStates>{
  MainBlocs():super(InitMainStates()){
    on<ToggleThemeEvent>((event,emit){
     emit(MainStates(themeMode: event.themeMode));
    });


  }

}