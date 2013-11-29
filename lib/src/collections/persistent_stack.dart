part of restlib.common.collections;

abstract class PersistentStack<E> implements Stack<E> {  
  static const PersistentStack EMPTY = const _PersistentStackBase._empty();
  
  factory PersistentStack.from(final Iterable<E> src) =>
    src.fold(EMPTY, (final PersistentStack<E> retval, final E element) => 
          retval.push(element));
  
  PersistentStack<E> get tail;    
  
  PersistentStack<E> push(E value);
}

class _PersistentStackBase<E> extends IterableBase<E> implements PersistentStack<E> {  
  final E _head;
  final E _last;
  final int length;
  final PersistentStack _tail;
      
  _PersistentStackBase._internal(final E head, final PersistentStack<E> tail):
    this._head = checkNotNull(head),
    this._tail = checkNotNull(tail),
    this._last = (tail.isEmpty ? head : tail.last),
    this.length = 1 + tail.length;
  
  const _PersistentStackBase._empty() :
    this._head = null,
    this._last = null,
    this.length = 0,
    this._tail = null;
  
  E get first =>
    (!isEmpty) ? _head : throw new StateError("Stack is empty");
  
  int get hashCode => computeHashCode(this);
  
  bool get isEmpty => length == 0;
  
  Iterator<E> get iterator => new _PersistentStackIterator._internal(this);
  
  E get last => 
      (!isEmpty) ? _last : throw new StateError("Stack is empty");

  E get single {
    if (!isEmpty && tail.isEmpty) {
      return _head;
    } else if (isEmpty) {
      throw new StateError("Stack is empty");
    } else {
      throw new StateError("Stack has more than one element");
    }
  }
  
  PersistentStack get tail =>
      isEmpty ? throw new StateError("Stack is empty") : this._tail;
  
  bool operator==(other){
    if (identical (this, other)) {
      return true;
    } else if (other is PersistentStack) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  PersistentStack<E> push(final E value) =>
      new _PersistentStackBase._internal(value, this);
  
  String toString() =>
      "[${join(", ")}]";
}

class _PersistentStackIterator<E> implements Iterator<E> {
  E _head;
  PersistentStack<E> _tail;
  
  _PersistentStackIterator._internal(final PersistentStack<E> stack) :
    _head = null,
    _tail = stack;
  
  E get current => 
      _head;
  
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