part of restlib.common.collections;

class GrowableSequence<E> extends _AbstractMutableSequence<E> implements MutableSequence<E> {  
  GrowableSequence() : super (new List());
  
  Iterator<E> get iterator =>
      _delegate.iterator;
  
  int get length => 
      _delegate.length;
  
  void operator[]=(final int index, final E value) =>
      (_delegate as List)[index] = checkNotNull(value);
  
  void add(final E element) =>
      (_delegate as List).add(checkNotNull(element));
  
  bool remove(E element) =>
      (_delegate as List).remove(element);
  
  Option<E> removeAt(int index) {
    checkArgument(index > 0);
    
    if (index < length) {
      return new Option((_delegate as List).removeAt(index));
    } else {
      return Option.NONE;
    }
  }
      
  String toString() => 
      _delegate.toString();
}
