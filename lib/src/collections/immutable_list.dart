part of restlib.common.collections;

class ImmutableList<E> extends Object with IterableMixin<E> {
static final ImmutableList EMPTY = new ImmutableList._internal([]);
  
  factory ImmutableList.from(Iterable<E> elements) {
    if (elements is ImmutableList) {
      return elements;
    }
    
    List<E> list = new List(elements.length)..setAll(0, elements);
    return new ImmutableList._internal(list);
  }
  
  final List<E> _list;
  
  ImmutableList._internal(this._list);

  E operator [](int index) => _list[index];
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is ImmutableList && 
        (this.length == (other as ImmutableList).length)) {
      ImmutableList that = other;
      for (int i = 0; i < this.length; i++) {
        if (this[i] != that[i]) { return false; };
      }
      return true; 
    } else {
      return false;
    }
  }
  
  Iterator<E> get iterator => _list.iterator;
  
  int get hashCode => computeHashCode(this);

  Iterable<E> getRange(int start, int end) {
    return skip(start).take(end - start);
  }
  
  int indexOf(E element, [int start = 0]) => _list.indexOf(element, start);
  
  String toString() {
    return _list.toString();
  }
}
