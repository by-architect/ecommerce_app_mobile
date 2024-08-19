import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
    this.isFilterIconActive = false,
    this.textEditingController,
    this.formKey,
    this.isEnabled = true,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onTabFilter,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  final GlobalKey<FormState>? formKey;
  final bool isEnabled;
  final ValueChanged<String?>? onSaved, onChanged, onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTabFilter;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isFilterIconActive;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        autofocus: autofocus,
        focusNode: focusNode,
        enabled: isEnabled,
        onChanged: onChanged,
        onSaved: onSaved,

        controller:  textEditingController,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: AppText.discoverPageFindSomething,
          filled: false,
          // border: AppStyles.secondaryOutlineInputBorder(context),
          // enabledBorder: AppStyles.secondaryOutlineInputBorder(context),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search,color: AppColors.greyColor,),
          ),
          suffixIcon: isFilterIconActive ? SizedBox(
            width: 40,
            child: Row(
              children: [
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(width: 1),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: onTabFilter,
                    icon: SvgPicture.asset(
                      AppImages.filterIcon,
                      height: 24,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ],
            ),
          ): const SizedBox.shrink(),
        ),
      ),
    );
  }
}