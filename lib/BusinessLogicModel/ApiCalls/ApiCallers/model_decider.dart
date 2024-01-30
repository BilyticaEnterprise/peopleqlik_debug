class ClassType<T> {
  final T Function(Map<String, dynamic>) createT;

  ClassType(this.createT);

  T callCConstructor(Map<String, dynamic> map) {
    T t = createT(map);
    return t;
  }
}