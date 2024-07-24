import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';

enum Gender {
  man(AppText.man),
  woman(AppText.woman),
 unselected(AppText.gender);

  final String text;
  const Gender(this.text);

static List<Gender> toList(){
    return [
      Gender.unselected,
      Gender.man,
      Gender.woman
    ] ;
  }
}