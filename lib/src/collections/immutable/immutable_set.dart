part of restlib.common.collections.immutable;

abstract class ImmutableSet<E> 
    extends ImmutableCollection<E> 
    implements FiniteSet<E>{  
  
  /*     
   * Returns the hash code value for this set. The hash code of a set 
   * is defined to be the sum of the hash codes of the elements in the 
   * set, where the hash code of a null element is defined to be zero. 
   * This ensures that s1.equals(s2) implies that s1.hashCode()==s2.hashCode() 
   * for any two sets s1 and s2, as required by the general contract of Object.hashCode(). 
   */
  static int computeHashCode(final ImmutableSet set) =>
    set.fold(0, (final int prev, final dynamic element) =>
        prev + element.hashCode);
  
  static bool setsEqual(final ImmutableSet set1, final ImmutableSet set2) =>
      (set1.length != set2.length) ? 
          false : set1.every((final dynamic element) => 
              set2.contains(element));
      
  ImmutableSet<E> add(E value);
  ImmutableSet<E> addAll(Iterable<E> elements);
  ImmutableSet<E> remove(E element);
  

  ImmutableSet<E> difference(FiniteSet<E> other);
  ImmutableSet<E> intersection(FiniteSet<Object> other);
  ImmutableSet<E> union(FiniteSet<E> other);
}

abstract class _ImmutableSetBase<E> 
    extends DictionaryBackedSet<E> 
    implements ImmutableSet<E> {
  const _ImmutableSetBase();
  
  int get hashCode =>
      ImmutableSet.computeHashCode(this);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSet) {
      return ImmutableSet.setsEqual(this, other);
    } else {
      return false;
    }
  }
}