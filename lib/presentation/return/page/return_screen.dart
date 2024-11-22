import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/user.dart';
import '../bloc/return_bloc.dart';
import '../bloc/return_state.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReturnBloc, ReturnState>(
      builder: (BuildContext context, ReturnState state) =>
          Scaffold(
            appBar: AppBarPopBack(
                title: AppText.returnPageReturn.capitalizeEveryWord.get),
            body:Placeholder(),
          ),
    );
  }
}
