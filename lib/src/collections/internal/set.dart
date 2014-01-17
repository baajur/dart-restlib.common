part of  restlib.common.collections.internal;

abstract class DictionaryBackedSet<E> 
    extends IterableBase<E>
    implements FiniteSet<E> {
      
  const DictionaryBackedSet();    
      
  Dictionary<E,E> get delegate;
  
  E get first =>
      delegate.first.fst;
  
  bool get isEmpty =>
      delegate.isEmpty;
  
  Iterator<E> get iterator =>
      delegate.keys.iterator;
  
  E get last =>
      delegate.last.fst;
  
  int get length =>
      delegate.length;
  
  E get single =>
      delegate.single.fst;
  
  bool contains(final E element) =>
      delegate[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  String toString() =>
      "[" + join(", ") + "]";
}