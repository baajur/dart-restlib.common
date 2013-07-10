part of restlib.common.collections;

class _SequenceIterator<E> implements Iterator<E> {
  final Sequence<E> _list;
  int _currIndex = -1;
  
  _SequenceIterator(this._list);
  
  E get current => 
      (_currIndex < 0 || _currIndex >= _list.length) ?
          null : _list[_currIndex].value;

  bool moveNext() =>
      (++_currIndex) < _list.length; 
}

class _ReverseSequence<E> extends IterableBase<E> implements Sequence<E> { 
  final Sequence<E> reversed;
  
  _ReverseSequence(this.reversed);
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  int get length =>
      reversed.length;
  
  Option<E> operator[](final int index) =>
      reversed[reversed.length - index - 1];
}

class _SubSequence<E> extends IterableBase<E> implements Sequence<E> { 
  final Sequence<E> delegate;
  final int _start;
  final int length;
  
  _SubSequence(this.delegate, this._start, this.length) {
    checkArgument(_start + length <= delegate.length);
  }
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  Sequence<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](final int index) =>
      delegate[_start + index];
}