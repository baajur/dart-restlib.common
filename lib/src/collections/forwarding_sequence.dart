part of restlib.common.collections;

class ForwardingSequence<E> extends ForwardingIterable<E> implements Sequence<E> {
  ForwardingSequence(final Sequence<E> delegate) : super(delegate);
  
  Iterable<E> get reversed => (super._delegate as Sequence).reversed;
  
  Option<E> operator[](int index) => (super._delegate as Sequence)[index];
}