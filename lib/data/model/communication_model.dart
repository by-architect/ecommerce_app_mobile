import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';

import '../../common/ui/theme/AppText.dart';

class ContactModel {
  final ContactType type;
  final String content;

  const ContactModel({required this.type, required this.content});
}

enum ContactType {
  whatsapp(AppText.whatsapp,icon: AppImages.whatsappIcon),
  email(AppText.email,icon: AppImages.mailIcon),
  phoneNo(AppText.phoneNo,icon: AppImages.phoneIcon),
  other(AppText.others);

  final AppText userText;
  final String icon;

  const ContactType(this.userText, {this.icon = ""});

}
