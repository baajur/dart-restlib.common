part of restlib.common.collections;

class ImmutableSet<E> extends Object with IterableMixin<E> {
  static final ImmutableSet EMPTY = new ImmutableSet._internal(ImmutableMap.EMPTY);
  
  final ImmutableMap<E,E> _set;
 
  const ImmutableSet._internal(this._set);
   
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
}