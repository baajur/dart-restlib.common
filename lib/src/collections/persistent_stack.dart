part of common.collections;

class PersistentStack<E> extends IterableBase<E> implements ImmutableStack<E> {  
  static const PersistentStack EMPTY = const PersistentStack._internal(null, null);
  
  factory PersistentStack.from(final Iterable<E> src) =>
    checkNotNull(src)
      .fold(EMPTY, (PersistentStack retval, E element) => 
          retval.add(element));
  
  final E _head;
  final E _last;
  final int length;
  final PersistentStack _tail;
      
  // This code assumes either either head and rest are both null or neither null.
  const PersistentStack._internal(final E head, final PersistentStack<E> rest):
    this._head = head,
    this._last = isNull(rest) ? null : (rest.isEmpty ? head : rest.last),
    this.length = isNotNull(head) ? 1 + rest.length : 0,
    this._tail = rest;
  
  E get first {
    if (!isEmpty) {
      return _head;
    } else {
      throw new StateError("Stack is empty");
    }
  }
  
  int get hashCode => computeHashCode(this);
  
  bool get isEmpty => identical(this, EMPTY);
  
  Iterator<E> get iterator => new _PersistentStackIterator._internal(this);
  
  E get last {
    if (!isEmpty) {
      return _last;
    } else {
      throw new StateError("Stack is empty");
    } 
  }

  E get single {
    if (!isEmpty && tail.isEmpty) {
      return _head;
    } else if (isEmpty) {
      throw new StateError("Stack is empty");
    } else {
      throw new StateError("Stack has more than one element");
    }
  }
  
  PersistentStack get tail {
    if (isEmpty) {
      throw new StateError("Stack is empty");
    } else {
      return this._tail;
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
  
  ImmutableStack<E> add(final E value) =>
      new PersistentStack._internal(checkNotNull(value), this);
  
  String toString() =>"[${join(", ")}]";
}

class _PersistentStackIterator<E> implements Iterator<E> {
  E _head;
  PersistentStack<E> _tail;
  
  _PersistentStackIterator._internal(final PersistentStack<E> stack) :
    _head = null,
    _tail = stack;
  
  E get current => _head;
  
  bool moveNext() {
    if (!_tail.isEmpty) {
      _head = _tail.first;
      _tail = _tail.tail;
      return true;
    } else {
      _head = null;
      return false;
    }
  }
}