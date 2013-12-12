part of restlib.common.collections;

abstract class ImmutableStack<E> implements Stack<E> {    
  ImmutableStack<E> get tail;    
  
  ImmutableStack<E> push(E value);
  
  ImmutableStack<E> pushAll(Iterable<E> value);
}