import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../common/widgets/fail_form.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/bloc/search_event.dart';
import '../bloc/main_blocs.dart';
import '../bloc/main_events.dart';

class MainFailForm extends StatelessWidget {
  const MainFailForm({super.key, required this.failState});

  final MainLoadFailState failState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: FailForm(
            fail: failState.fail,
            onRefreshTap: () {
              BlocProvider.of<MainBlocs>(context).add(GetInitItemsEvent());
              BlocProvider.of<HomeBloc>(context).add(GetProductsHomeEvent());
              BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent());
            },
          ),
        ),
      ),
    );
  }
}
