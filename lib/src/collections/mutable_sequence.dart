part of restlib.common.collections;

abstract class MutableSequence<E> implements Sequence<E>, MutableCollection<E>, MutableAssociative<int, E> {      
}

abstract class _AbstractMutableSequence<E> 
    extends _SequenceBase<E>
    implements MutableSequence<E>, Forwarder {  
  _AbstractMutableSequence();
  
  Option<E> operator[](final int index) =>
      (index >= 0 && index < length) ? 
          new Option(delegate[index]) : 
            Option.NONE;        
          
  int indexOf(E element, [int start=0]) =>
      delegate.indexOf(checkNotNull(element), start);
  
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
  
  E elementAt(final int index) =>
      (index >= 0 && index < length) ?
        delegate[index] :
          throw new RangeError.range(index, 0, length - 1);   
}