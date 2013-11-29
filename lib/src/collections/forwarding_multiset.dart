part of restlib.common.collections;

class ForwardingMultiset<E> extends ForwardingIterable<E> implements Multiset<E> {
  const ForwardingMultiset(final Multiset<E> delegate) : super(delegate);
  
  int count(final E element) =>
      (_delegate as Multiset).count(element);
}