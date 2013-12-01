part of restlib.common.collections;

abstract class MutableSequence<E> implements Sequence<E>, MutableCollection<E>, MutableAssociative<int, E> {      
}

abstract class _AbstractMutableSequence<E> 
    extends Object
    with ForwardingIterable<E>, 
      ToStringForwarder
    implements MutableSequence<E>, Forwarder {
  final List<E> delegate;
  
  _AbstractMutableSequence(this.delegate);
  
  Iterable<int> get keys =>
      new List.generate(length, 
          (final int index) => index);
  
  Iterable<E> get values =>
      this;
  
  Iterable<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](final int index) =>
      (index >= 0 && index < length) ? 
          new Option(delegate[index]) : 
            Option.NONE;
  
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
      delegate.contains(element);
  
  E elementAt(final int index) =>
      (index >= 0 && index < length) ?
        delegate[index] :
          throw new RangeError.range(index, 0, length - 1);   
  
  Sequence<E> subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
}