part of restlib.common.collections;

class ForwardingStack<E> extends ForwardingIterable<E> implements Stack<E> {
  const ForwardingStack(final Stack<E> delegate) : super(delegate);
  
  Stack<E> get tail =>
      (_delegate as Stack).tail;
}