part of restlib.common.collections;

abstract class ImmutableList<E> extends Iterable<E>{
  ImmutableList<E> add(E element);
  
  ImmutableList<E> addAll(Iterable<E> iterable); 
  
  ImmutableList<E> getRange(int start, int end);
  
  int indexOf(E element, [int start = 0]);
  
  ImmutableList<E> insert(int index, E element);
  
  ImmutableList<E> insertAll(int index, Iterable<E> iterable);
  
  ImmutableList<E> sort();
  
  ImmutableList<E> sublist(int start, [int end]);
  
  Option<E> operator [](int index);
}
