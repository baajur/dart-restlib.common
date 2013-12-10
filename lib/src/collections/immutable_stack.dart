part of restlib.common.collections;

abstract class ImmutableStack<E> implements Stack<E> {  
  static const ImmutableStack EMPTY = const _PersistentStackBase._empty();
  
  factory ImmutableStack.from(final Iterable<E> src) =>
    src.fold(EMPTY, (final ImmutableStack<E> retval, final E element) => 
          retval.push(element));
  
  ImmutableStack<E> get tail;    
  
  ImmutableStack<E> push(E value);
  
  ImmutableStack<E> pushAll(Iterable<E> value);
}