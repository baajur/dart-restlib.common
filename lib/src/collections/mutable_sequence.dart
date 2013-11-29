part of restlib.common.collections;

abstract class MutableSequence<E> implements Sequence<E> {    
  void operator[]=(int index, E element);
  
  void add(E value);
  
  void addAll(Iterable<E> elements);
  
  void insert(int index, E element);
  
  bool remove(E element);
  
  Option<E> removeAt(int index);
}

abstract class _AbstractMutableSequence<E> extends ForwardingIterable<E> implements MutableSequence<E> {
  _AbstractMutableSequence(List<E> delegate) : super (delegate);
  
  Iterable<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](final int index) =>
      (index >= 0 && index < length) ? 
          new Option((_delegate as List)[index]) : 
            Option.NONE;
          
  void addAll(final Iterable<E> elements) =>
      elements.forEach((final E element) => 
          add(element));
  
  bool containsKey(final int key) =>
      (key >= 0) && (key < length);
  
  E elementAt(final int index) =>
      (index >= 0 && index < length) ?
        (_delegate as List)[index] :
          throw new RangeError.range(index, 0, length - 1);
          
  void insert(final int index, final E element) {
    this[index] = element;
  }        
  
  Sequence<E> subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
}