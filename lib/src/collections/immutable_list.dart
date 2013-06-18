part of restlib.common.collections;

class ImmutableList<E> extends Object with IterableMixin<E> {
  static final ImmutableList EMPTY = new ImmutableList._internal([]);
  
  factory ImmutableList.from(final Iterable<E> elements) {
    if (elements is ImmutableList) {
      return elements;
    }
    return new ImmutableList._internal(elements.toList(growable: false));
  }
  
  final List<E> _list;
  
  ImmutableList._internal(this._list);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is ImmutableList && 
        (this.length == (other as ImmutableList).length)) {
      return equal(this, other); 
    } else {
      return false;
    }
  }
  
  Iterator<E> get iterator => _list.iterator;
  
  int get hashCode => computeHashCode(this);
  
  String toString() {
    return _list.toString();
  }
}
