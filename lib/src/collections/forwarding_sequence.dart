part of restlib.common.collections;

class ForwardingSequence<E> extends ForwardingIterable<E> implements Sequence<E> {
  const ForwardingSequence(final Sequence<E> delegate) : super(delegate);
  
  Iterable<E> get reversed => 
      (_delegate as Sequence).reversed;
  
  Option<E> operator[](int index) => 
      (_delegate as Sequence)[index];
}