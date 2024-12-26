import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/enum_helper.dart';

import '../../common/ui/theme/AppText.dart';

class ContactModel {
  final ContactType type;
  final String content;

  const ContactModel({required this.type, required this.content});

  factory ContactModel.fromJson(Map<String, dynamic> map) {
    return ContactModel(
      type: EnumHelper.fromJson(ContactType.values, map['type']),
      content: map['content'],
    );
  }

  @TestOnly()
  Map<String, dynamic> toJson() {
    return {
      'type': type.toJson(),
      'content': content,
    };
  }
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
