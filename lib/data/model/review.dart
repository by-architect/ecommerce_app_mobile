import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';

class Review {
  final ReviewStar star;
  final String title;
  final String content;
  final User user;
  final DateTime dateTime;

  Review({
  required  this.star,
  required  this.title,
  required  this.content,
  required  this.user,
  required  this.dateTime});


}
