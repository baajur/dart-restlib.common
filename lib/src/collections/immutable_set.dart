part of restlib.common.collections;

abstract class ImmutableSet<E> implements Iterable<E> {
  int get hashCode;
  
  bool operator==(other);
  
  Option<E> operator[](E obj);
  
  ImmutableSet<E> add(E value);
  ImmutableSet<E> addAll(Iterable<E> values);
}