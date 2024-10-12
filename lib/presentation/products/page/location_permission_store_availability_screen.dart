import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class LocationPermissionStoreAvailabilityScreen extends StatelessWidget {
  const LocationPermissionStoreAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    AppText.productPageStorePickupAvailability.capitalizeFirstWord,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: "Find something...",
                          border:AppStyles.secondaryOutlineInputBorder(context),
                          enabledBorder: AppStyles.secondaryOutlineInputBorder(context),
                          focusedBorder: AppStyles.secondaryOutlineInputBorder(context),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
                            child: SvgPicture.asset(
                              AppImages.searchIcon,
                              height: 24,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle!
                                  .color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.defaultPadding * 1.5),
                        child: Image.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? "assets/Illustration/Illustration-4.png"
                              : "assets/Illustration/Illustration_darkTheme_4.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                    ),
                    Text(
                      "Your Location Services are turned off.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                    const SizedBox(height: AppSizes.defaultPadding),
                    const Text(
                      "Turn on Location Services in your device Settings to search for stores by current location. You can still search by Country/Region, City or Zip Code.",
                    ),
                    const SizedBox(height: AppSizes.defaultPadding * 1.5),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Settings"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
