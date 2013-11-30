part of restlib.common.collections;

abstract class ForwardingMultiset<E> implements Forwarder, Multiset<E> {  
  int count(final E element) =>
      delegate.count(element);
}