part of common.collections;


class CopyOnWriteStack<E> extends IterableBase<E> implements ImmutableStack<E> {  
  static const CopyOnWriteStack EMPTY = const CopyOnWriteStack._empty();
  
  factory CopyOnWriteStack.from(final Iterable<E> src) =>
      new CopyOnWriteStack._internal(
          checkNotNull(src).toList().reversed);

  final Iterable<E> _list;
  
  const CopyOnWriteStack._empty() :
    _list = [];
  
  // This code assumes either either head and rest are both null or neither null.
  const CopyOnWriteStack._internal(final Iterable<E> list) :
    _list = list;
  
  int get hashCode => computeHashCode(this);
  
  Iterator<E> get iterator => _list.iterator;
  
  CopyOnWriteStack get tail {
    if (isEmpty) {
      throw new StateError("Stack is empty");
    } else if (_list.length == 1) {
      return EMPTY;
    } else {
      return new CopyOnWriteStack._internal(_list.skip(1));
    }
  }
  
  bool operator==(other){
    if (identical (this, other)) {
      return true;
    } else if (other is ImmutableStack) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  CopyOnWriteStack<E> add(final E value) {
    checkNotNull(value);
    if (isEmpty) {
      return new CopyOnWriteStack._internal([value]);
    } else {
      final List<E> newList = new List(length + 1)..[0]=value..setAll(1, this);
      return new CopyOnWriteStack._internal(newList);
    }
  }
  
  String toString() =>"[${join(", ")}]";
}
