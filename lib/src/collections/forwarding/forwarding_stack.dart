part of collections.forwarding;

abstract class ForwardingStack<E> implements Forwarder, Stack<E> {
  Stack<E> get tail =>
      delegate.tail;
}