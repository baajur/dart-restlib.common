part of collections;



class _Pair<T0, T1> extends IterableBase implements Pair<T0, T1> {
  final T0 e0;
  final T1 e1;

  _Pair(this.e0, this.e1);

  int get hashCode =>
      computeHashCode([e0, e1]);

  bool get isEmpty =>
      false;

  Iterator get iterator =>
      [e0, e1].iterator;

  int get length => 2;

  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Pair) {
      return this.e0 == other.e0 &&
          this.e1 == other.e1;
    } else {
      return false;
    }
  }

  String toString() =>
      "Pair($e0, $e1)";
}
