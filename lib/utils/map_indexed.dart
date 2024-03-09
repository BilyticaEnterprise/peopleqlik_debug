Iterable<E> mapIndexed<E, T>(Iterable<dynamic> items, E Function(int index, dynamic item) f)
sync* {
  var index = 0;
  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
}