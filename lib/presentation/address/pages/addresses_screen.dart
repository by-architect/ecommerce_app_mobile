import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/pages/add_address_screen.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/map_picker.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/user.dart';
import '../../common/widgets/fail_form.dart';
import '../bloc/addresses_event.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key, required this.user});

  final User user;

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    BlocProvider.of<AddressesBloc>(context).add(GetAddressesEvent(widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesBloc, AddressesState>(
      builder: (BuildContext context, AddressesState state) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarPopBack(
            title: AppText.addressesPageAddresses.capitalizeFirstWord.get,
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Column(
              children: [
                ButtonSecondary(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(user: widget.user)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.locationIcon),
                      const SizedBox(
                        width: AppSizes.spaceBtwHorizontalFields,
                      ),
                      Text(AppText.addressesPageAddAddress.capitalizeEveryWord.get)
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFields,
                ),
                Expanded(
                  child: switch (state) {
                    AddressesLoadingState _ => const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        OffersSkeleton(),
                        SizedBox(
                          height: AppSizes.spaceBtwVerticalFields,
                        ),
                        OffersSkeleton(),
                        SizedBox(
                          height: AppSizes.spaceBtwVerticalFields,
                        ),
                        OffersSkeleton(),
                      ]),
                    AddressesFailState failState => FailForm(
                        onRefreshTap: () {
                          BlocProvider.of<AddressesBloc>(context).add(GetAddressesEvent(widget.user));
                        },
                        fail: failState.fail,
                      ),
                    AddressesSuccessState _ || AddressesState _ => ListView.builder(
                        itemBuilder: (context, index) =>
                            AddressCard(isSelected: false, address: state.addresses[index]),
                        itemCount: state.addresses.length)
                  },
                ),
              ],
            ),
          )),
    );
  }
}
