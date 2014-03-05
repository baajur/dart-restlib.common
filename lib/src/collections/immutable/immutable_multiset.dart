part of collections.immutable;

abstract class ImmutableMultiset<E> implements ImmutableCollection<E>, Multiset<E> {    
  bool operator==(other);
  
  ImmutableMultiset<E> add(E value);
  
  ImmutableMultiset<E> addAll(Iterable<E> elements);  
  
  ImmutableMultiset<E> remove(E element);
  
  ImmutableMultiset<E> removeAll(final E element);
}

abstract class _ImmutableMultisetBase<E> extends IterableBase<E> implements ImmutableMultiset<E> {
  const _ImmutableMultisetBase();
  
  // From guava
  // Returns the hash code for this multiset. This is defined as the sum of
  // element.hashCode() ^ count(element)
  // over all distinct elements in the multiset. It follows that a multiset and its entry set always have the same hash code.
  int get hashCode =>
      this.elements.fold(0, (final int acc, final E next ) => 
          acc + (next.hashCode ^ this.count(next)));
      
  bool operator==(other) {
    if (identical(this,other)) {
      return true;
    } else if (other is ImmutableMultiset) {
      return (this.elements.length == other.elements.length)  &&
        this.elements.every((final E element) => 
            this.contains(element) == other.contains(element));
    } else {
      return false;
    }
  }
}