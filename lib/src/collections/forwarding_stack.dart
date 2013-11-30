part of restlib.common.collections;

abstract class ForwardingStack<E, D extends Stack<E>> implements Forwarder<D>, Stack<E> {
  Stack<E> get tail =>
      delegate.tail;
}