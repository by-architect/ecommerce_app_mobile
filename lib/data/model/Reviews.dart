import 'package:ecommerce_app_mobile/data/model/review.dart';

class Reviews {
  late final String productId;
  late final List<Review> _list;
  late final double rating;
  late final List<int> _stars;

  String get ratingString => rating.toStringAsFixed(2);

  int getStarCount(ReviewStar reviewStar) => _stars.isEmpty ? 0: _stars[reviewStar.starIndex];

  double getStarCountPercent(ReviewStar reviewStar) => _stars.isEmpty ? 0 : getStarCount(reviewStar) / _stars.length;

  List<Review> get list => _list;

  int get count => _list.length;

  double get ratingPercent => _list.isEmpty ? 0 : rating / _list.length;

  Reviews(this.productId,this._list) {
    _loadStars();
  }

  Reviews.empty() {
    productId = "";
    _list = [];
    rating = 0;
    _stars = [];
  }

  _loadStars() {
    double rating = 0;
    int fiveStars = 0;
    int fourStars = 0;
    int threeStars = 0;
    int twoStars = 0;
    int oneStars = 0;

    for (Review review in _list) {
      rating += review.star.starRating;
      switch (review.star) {
        case ReviewStar.one:
          oneStars++;
          break;
        case ReviewStar.two:
          twoStars++;
          break;
        case ReviewStar.three:
          threeStars++;
          break;
        case ReviewStar.four:
          fourStars++;
          break;
        case ReviewStar.five:
          fiveStars++;
          break;
      }
    }

    this.rating = _list.isEmpty ? 0 : rating / count;
    _stars= [];
    _stars.add(oneStars);
    _stars.add(twoStars);
    _stars.add(threeStars);
    _stars.add(fourStars);
    _stars.add(fiveStars);
  }


/*
  double get rating {
    double rating = 0;
    if (_list.isEmpty) return rating;
    for (var review in _list) {
      rating += review.rating;
    }
    return rating / _list.length;
  }
*/
}

enum ReviewStar {
  one(1, 0),
  two(2, 1),
  three(3, 2),
  four(4, 3),
  five(5, 4);

  final int starRating;
  final int starIndex;

  static ReviewStar? getByInt(int value) => switch(value){
   1 => ReviewStar.one,
    2 => ReviewStar.two,
    3 => ReviewStar.three,
    4 => ReviewStar.four,
    5 => ReviewStar.five,

    int() => null
  };

  const ReviewStar(this.starRating, this.starIndex);
}
