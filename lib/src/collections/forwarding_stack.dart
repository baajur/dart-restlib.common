part of restlib.common.collections;

abstract class ForwardingStack<E> implements Forwarder, Stack<E> {
  Stack<E> get tail =>
      delegate.tail;
}