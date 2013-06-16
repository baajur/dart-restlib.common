part of common.collections;

class CopyOnWriteSet<E> extends IterableBase<E> implements ImmutableSet<E> {
  static final CopyOnWriteSet EMPTY = new CopyOnWriteSet._internal(CopyOnWriteMap.EMPTY);
  
  final ImmutableMap<E,E> _set;
 
  const CopyOnWriteSet._internal(this._set);
   
  int get hashCode => _set.hashCode;
  
  Option<E> operator[](final E obj) => _set[obj];
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSet) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  CopyOnWriteSet<E> add(final E value) =>
      _set[value]
        .map((value) => this)
        .orCompute(() => new CopyOnWriteSet(_set.insert(value, value)));
  
  CopyOnWriteSet<E> addAll(final Iterable<E> values);
}