import '../../../data/model/Reviews.dart';
import '../../../data/model/user.dart';

class ReviewState {
  ReviewStar? star;
  String? title;
  String? content;
  DateTime? dateTime;

  ReviewState({this.star, this.title, this.content, this.dateTime});

  ReviewState copyWith({ReviewStar? star, String? title, String? content, User? user, DateTime? dateTime}) {
    return ReviewState(
      star: star ?? this.star,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ReviewState changeStar(ReviewStar? star) {
    return ReviewState(star: star, title: title, content: content, dateTime: dateTime);
  }

  @override
  String toString() {
    return 'ReviewState{star: $star, title: $title, content: $content,  dateTime: $dateTime}';
  }
}
