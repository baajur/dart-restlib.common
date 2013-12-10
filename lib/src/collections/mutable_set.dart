part of restlib.common.collections;

abstract class MutableSet<E> extends MutableCollection<E> implements FiniteSet<E>{
  factory MutableSet.hash({final Iterable<E> elements}) =>
      (elements != null) ?
          elements.fold(
              new _MutableDictionaryBackedSet(new MutableDictionary.hash()), 
              (final MutableSet<E> accumulator, final E element) => 
                  accumulator..add(element)) :
            new _MutableDictionaryBackedSet(new MutableDictionary.hash());
  
  factory MutableSet.splayTree({final Iterable<E> elements}) =>
      (elements != null) ?
          elements.fold(
              new _MutableDictionaryBackedSet(new MutableDictionary.splayTree()), 
              (final MutableSet<E> accumulator, final E element) => 
                  accumulator..add(element)) :
            new _MutableDictionaryBackedSet(new MutableDictionary.splayTree());
  
  MutableSet<E> difference(FiniteSet<E> other);
  MutableSet<E> intersection(FiniteSet<Object> other);
  MutableSet<E> union(FiniteSet<E> other);
}

class _MutableDictionaryBackedSet<E> 
    extends _DictionaryBackedSet 
    implements MutableSet<E> {   
  final MutableDictionary<E,E> delegate;
  
  _MutableDictionaryBackedSet(this.delegate);
  
  void add(final E element) =>
      delegate.insert(element, element);
  
  void addAll(final Iterable<E> elements) =>
      elements.forEach((final E element) => 
          add(element));
  
  void clear() =>
      delegate.clear();
  
  MutableSet<E> difference(FiniteSet<E> other) =>
    // FIXME: Probaly should make the return type implementation specific
    new MutableSet.hash()..addAll(
        this.where((final E element) => 
            !other.contains(element)));

  MutableSet<E> intersection(FiniteSet<Object> other) =>
    // FIXME: Probaly should make the return type implementation specific
    new MutableSet.hash()..addAll(
        this.where((final E element) => 
            other.contains(element)));
  
  MutableSet<E> union(FiniteSet<E> other) =>
    // FIXME: Probaly should make the return type implementation specific
    new MutableSet.hash()..addAll(this)..addAll(other);
  
  Option<E> remove(final E element) =>
      delegate.removeAt(element);
}