extension IndexedIterable<E> on Iterable<E> {
  Iterable<(E, int)> mapIndexed() sync* {
    var index = 0;
    for (var element in this) {
      yield (element, index);
      index++;
    }
  }
}