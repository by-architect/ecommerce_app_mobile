import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';

enum Gender {
  man(AppText.man),
  woman(AppText.woman),
  unselected(AppText.gender);

  final AppText text;

  const Gender(this.text);

  static List<Gender> toList() {
    return [Gender.unselected, Gender.man, Gender.woman];
  }

  static fromString(String gender) {
    if (gender == Gender.man.name) {
      return Gender.man;
    } else {
      return Gender.woman;
    }
  }
}
