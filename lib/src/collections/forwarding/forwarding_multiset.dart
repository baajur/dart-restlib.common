part of restlib.common.collections.forwarding;

abstract class ForwardingMultiset<E> implements Forwarder, Multiset<E> {  
  int count(final E element) =>
      delegate.count(element);
}