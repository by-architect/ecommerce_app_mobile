import 'package:ecommerce_app_mobile/common/helper/UIHelper.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocs extends Bloc<MainEvents,MainStates>{
  MainBlocs():super(InitMainStates()){
    on<ToggleTheme>((event,emit){
     emit(MainStates(themeMode: event.themeMode));
    });
  }

}