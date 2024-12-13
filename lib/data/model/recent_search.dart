class RecentSearch {
  final String id;
  final String uid;
  final String text;

  RecentSearch(this.id, this.uid, this.text);

  factory RecentSearch.fromMap(Map<String, dynamic> json, String id) {
    return RecentSearch(id, json['uid'], json['search']);
  }

  @override
  String toString() {
    return 'RecentSearch{id: $id, uid: $uid, search: $text}';
  }
}

class RecentSearchState {
  final String recentSearch;
  final String uid;

  RecentSearchState({required this.recentSearch, required this.uid});

  Map<String, dynamic> toMap() => {'search': recentSearch, 'uid': uid}; //toMap
}
