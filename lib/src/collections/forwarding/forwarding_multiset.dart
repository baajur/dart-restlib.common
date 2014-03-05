part of collections.forwarding;

abstract class ForwardingMultiset<E> implements Forwarder, Multiset<E> {  
  int count(final E element) =>
      delegate.count(element);
}