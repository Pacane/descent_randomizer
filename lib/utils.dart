class Tuple<T1, T2> {
  final T1 f;
  final T2 s;

  Tuple(this.f, this.s);
}

List<T> getAllEnabled<T>(Map<T, bool> filters) =>
    filters.keys.where((T t) => filters[t] == true).toList();
