part of restlib.common.collections;

class CopyOnWriteList<E> extends IterableBase<E> implements ImmutableList<E> {
  static final CopyOnWriteList EMPTY = new CopyOnWriteList._internal([]);
  
  factory CopyOnWriteList.from(Iterable<E> elements) {
    if (elements is CopyOnWriteList) {
      return elements;
    }
    
    List<E> list = new List(elements.length)..setAll(0, elements);
    return new CopyOnWriteList._internal(list);
  }
  
  final List<E> _list;
  
  CopyOnWriteList._internal(this._list);

  E operator [](int index) => _list[index];
  
  CopyOnWriteList<E> operator []=(int index, E value) {
    return insert(index, value);
  }
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if(other is CopyOnWriteList && 
        (this.length = (other as CopyOnWriteList).length)) {
      CopyOnWriteList that = other;
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
  
  CopyOnWriteList<E> add(E element) {
    List<E> newList = new List(length + 1)..setAll(0, this)..insert(length, element);
    return new CopyOnWriteList._internal(newList);
  }
  
  CopyOnWriteList<E> addAll(Iterable<E> iterable) {
    List<E> newList = new List(length + iterable.length)..setAll(0, this)..setAll(length, iterable);
    return new CopyOnWriteList._internal(newList);
  }
  
  Iterable<E> getRange(int start, int end) {
    return skip(start).take(end - start);
  }
  
  int indexOf(E element, [int start = 0]) => _list.indexOf(element, start);
  
  CopyOnWriteList<E> insert(int index, E element) {
    if (index < 0 || index >= length) {
      throw new RangeError("Index: $index is out of range.");
    }
    
    List<E> newList = new List(length)..setAll(0, this)..insert(index, element);
    return new CopyOnWriteList._internal(newList);
  }
  
  CopyOnWriteList<E> insertAll(int index, Iterable<E> iterable) {
    if (index < 0 || index >= length) {
      throw new RangeError("Index: $index is out of range.");
    }
    
    int newLength = max(length, index+iterable.length);
    List<E> newList = new List(newLength)..setAll(0, this)..setAll(index, iterable);
    return new CopyOnWriteList._internal(newList);
  }
  
  CopyOnWriteList<E> sort([int compare(E a, E b)]) {
    List newList = new List(length)..setAll(0, this)..sort(compare);
    return new CopyOnWriteList._internal(newList);
  }
  
  CopyOnWriteList<E> sublist(int start, [int end]) {
    return new CopyOnWriteList._internal(this._list.sublist(start, end));
  }
  
  String toString() {
    return _list.toString();
  }
} 