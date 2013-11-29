part of restlib.common.collections;

class ForwardingSequence<E> extends ForwardingIterable<E> implements Sequence<E> {
  const ForwardingSequence(final Sequence<E> delegate) : super(delegate);
  
  Iterable<int> get keys =>
      (_delegate as Sequence).keys;
  
  Iterable<E> get reversed => 
      (_delegate as Sequence).reversed;
  
  Option<E> operator[](int index) => 
      (_delegate as Sequence)[index];
  
  bool containsKey(final int key) =>
      (_delegate as Sequence).containsKey(key);
  
  bool containsValue(final E value) =>
      (_delegate as Sequence).containsValue(value);
  
  Sequence<E> subSequence(int start, int length) =>
      (_delegate as Sequence).subSequence(start, length);
}