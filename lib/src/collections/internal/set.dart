part of  collections.internal;

abstract class DictionaryBackedSet<E> 
    extends IterableBase<E>
    implements FiniteSet<E> {
      
  const DictionaryBackedSet();    
      
  Dictionary<E,E> get delegate;
  
  E get first =>
      delegate.first.e0;
  
  bool get isEmpty =>
      delegate.isEmpty;
  
  Iterator<E> get iterator =>
      delegate.keys.iterator;
  
  E get last =>
      delegate.last.e0;
  
  int get length =>
      delegate.length;
  
  E get single =>
      delegate.single.e0;
  
  bool contains(final E element) =>
      delegate[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  String toString() =>
      "[" + join(", ") + "]";
}