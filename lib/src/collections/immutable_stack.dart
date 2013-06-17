part of restlib.common.collections;

abstract class ImmutableStack<E> implements Iterable<E> { 
  int get hashCode;
  
  ImmutableStack<E> get tail;
  
  bool operator==(other);
  
  ImmutableStack<E> add(E value);
}