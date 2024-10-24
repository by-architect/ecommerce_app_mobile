import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/address/pages/addresses_screen.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_event.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/card_info.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/order_summary.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/wallet_history_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/theme/AppStyles.dart';
import '../../../common/ui/theme/color_filters.dart';
import '../../../data/model/user.dart';

//todo: unimplemented

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key, required this.user});

  final User user;

  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardCvcController = TextEditingController();
  final TextEditingController cardDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) =>
          Scaffold(
            appBar: AppBarPopBack(
              title: AppText.paymentPageCompletePayment.capitalizeEveryWord.get,
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _Title(title: AppText.addressesPageAddresses.capitalizeEveryWord.get),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    if (state.selectedAddress != null)
                      Row(
                        children: [
                          Expanded(
                            child: AddressCard(
                                address: state.selectedAddress!,
                                isSelected: false,
                                onSelected: () {},
                            ),
                          ),
                        ],
                      ),
                    // if (state.selectedAddress != null) const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    ClickableWidgetOutlined(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddressesScreen(
                                    user: user,
                                    onSelected: (address) {
                                      BlocProvider.of<CartBloc>(context).add(SelectAddress(address: address));
                                    },
                                  )));
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SvgPicture.asset(state.selectedAddress == null ? AppImages.plusIcon : AppImages.editIcon, colorFilter: ColorFilters.greyIconColorFilter(context)),
                          const SizedBox(width: AppSizes.spaceBtwHorizontalFields),
                          Text(
                            state.selectedAddress == null
                                ? AppText.paymentPageSelectAddress.capitalizeEveryWord.get
                                : AppText.paymentPageChangeAddress.capitalizeEveryWord.get,
                          ),
                        ])),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFieldsLarge),
                    _Title(
                      title: AppText.paymentPagePaymentMethod.capitalizeEveryWord.get,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    Container(
                      padding: const EdgeInsets.all(AppSizes.defaultPadding),
                      decoration: AppStyles.defaultBoxDecoration,
                      child: Column(
                        children: [
                          Row(children: [
                            Flexible(
                              child: TextFieldDefault(
                                  maxLength: 40,
                                  onChanged: (p0) {},
                                  controller: nameSurnameController,
                                  enableLabel: true,
                                  labelOrHint: AppText.name.addSpace
                                      .combine(AppText.surname)
                                      .capitalizeEveryWord
                                      .get),
                            ),
                          ]),
                          const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                          Row(children: [
                            Flexible(
                              child: TextFieldDefault(
                                  isNumber: true,
                                  inputFormatters: [MaskedInputFormatter('#### #### #### ####')],
                                  onChanged: (p0) {},
                                  controller: cardNumberController,
                                  enableLabel: true,
                                  labelOrHint: AppText.paymentPageCardNumber.capitalizeEveryWord.get),
                            ),
                          ]),
                          const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                          Row(children: [
                            Flexible(
                              child: TextFieldDefault(
                                  onChanged: (p0) {},
                                  maxLength: 3,
                                  controller: cardCvcController,
                                  enableLabel: true,
                                  isNumber: true,
                                  labelOrHint: AppText.paymentPageCvcCvv.capitalizeEveryWord.get),
                            ),
                            const SizedBox(width: AppSizes.spaceBtwHorizontalFieldsLarge),
                            Flexible(
                              child: TextFieldDefault(
                                  onChanged: (text) {
                                    if (text.length == 1 && text.toInt > 1) {
                                      cardDateController.text = "0$text";
                                    }
                                    if (text.isNotEmpty && text.length < 3 && text.toInt > 12) {
                                      cardDateController.text = text.removeLast();
                                    }
                                  },
                                  isNumber: true,
                                  controller: cardDateController,
                                  inputFormatters: [
                                    MaskedInputFormatter(
                                      '##/##',
                                    )
                                  ],
                                  enableLabel: true,
                                  labelOrHint: AppText.paymentPageExpiryDate.capitalizeEveryWord.get),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFieldsLarge),
                    _Title(
                      title: AppText.cartPageOrderSummary.capitalizeEveryWord.get,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    OrderSummaryCard(
                      discount: state.discount,
                      shippingFee: state.shippingFee,
                      subtotal: state.subTotal,
                      total: state.total,
                      isReturn: false,
                      showOrderSummaryLabel: false,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFieldsLarge),
                    ButtonPrimary(
                      text: AppText.paymentPagePay.capitalizeEveryWord.get,
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
      ],
    );
    ;
  }
}
