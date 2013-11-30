part of restlib.common.collections;

abstract class ForwardingMultiset<E, D extends Multiset<E>> implements Forwarder<D>, Multiset<E> {  
  int count(final E element) =>
      delegate.count(element);
}