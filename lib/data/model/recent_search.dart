class RecentSearch{
  final String id;
  final String uid;
  final String text;

  RecentSearch(this.id, this.uid, this.text);

  @override
  String toString() {
    return 'RecentSearch{id: $id, uid: $uid, search: $text}';
  }
}