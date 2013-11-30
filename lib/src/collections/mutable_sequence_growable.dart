
part of restlib.common.collections;

abstract class GrowableSequence<E> implements MutableSequence<E> {  
  factory GrowableSequence() =>
      new _GrowableSequenceBase();
}

class _GrowableSequenceBase<E> extends _AbstractMutableSequence<E> implements GrowableSequence<E> {
  _GrowableSequenceBase() : super (new List());
  
  void operator[]=(final int index, final E value) =>
      delegate[index] = checkNotNull(value);
  
  void add(final E element) =>
      delegate.add(checkNotNull(element));
  
  Option<E> remove(E element) =>
      delegate.remove(element) ?
          new Option(element) : Option.NONE;
  
  Option<E> removeAt(int index) {
    checkArgument(index > 0);
    
    if (index < length) {
      return new Option(delegate.removeAt(index));
    } else {
      return Option.NONE;
    }
  }
}
