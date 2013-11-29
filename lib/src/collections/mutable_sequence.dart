part of restlib.common.collections;

abstract class MutableSequence<E> implements Sequence<E>, MutableCollection<E>, MutableAssociative<int, E> {      
}

abstract class _AbstractMutableSequence<E> extends ForwardingIterable<E> implements MutableSequence<E> {
  _AbstractMutableSequence(List<E> delegate) : super (delegate);
  
  Iterable<int> get keys =>
      new List.generate(length, 
          (final int index) => index);
  
  Iterable<E> get values =>
      this;
  
  Iterable<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](final int index) =>
      (index >= 0 && index < length) ? 
          new Option((_delegate as List)[index]) : 
            Option.NONE;
  
  void clear() =>
      (_delegate as List<E>).clear();
  
  void insertAll(final Iterable<Pair<int, E>> other) =>
      other.forEach((final Pair<int, E> pair) => 
          this.insert(pair.fst, pair.snd));
  
  void insert(final int key, final E value) {
      this[key] = value;
  }
  
  void insertPair(final Pair<int, E> pair) =>
      insert(pair.fst, pair.snd);
          
  void addAll(final Iterable<E> elements) =>
      elements.forEach((final E element) => 
          add(element));
  
  bool containsKey(final int key) =>
      (key >= 0) && (key < length);
  
  bool containsValue(final E element) =>
      _delegate.contains(element);
  
  E elementAt(final int index) =>
      (index >= 0 && index < length) ?
        (_delegate as List)[index] :
          throw new RangeError.range(index, 0, length - 1);   
  
  Sequence<E> subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
}