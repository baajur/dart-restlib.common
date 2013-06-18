part of restlib.common.collections;

class ImmutableSet<E> extends Object with IterableMixin<E> {
  static final ImmutableSet EMPTY = new ImmutableSet._internal(new Set());
  
  factory ImmutableSet.from(final Iterable<E> elements) {
    if (elements is ImmutableSet) {
      return elements;
    } else if (elements.isEmpty) {
      return EMPTY;
    } else {
      return new ImmutableSet._internal(elements.toSet());
    }
  }
  
  final Set<E> _set;
 
  ImmutableSet._internal(this._set);
   
  int get hashCode => computeHashCode(_set);
  
  Iterator<E> get iterator => _set.iterator;
  
  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSet) {
      return equal(this, other);
    } else {
      return false;
    }
  }
}