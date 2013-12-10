part of restlib.common.collections;

abstract class ImmutableSequence<E> implements Sequence<E>, ImmutableCollection<E>, ImmutableStack<E>, ImmutableAssociative<int, E> {  
  static const ImmutableSequence EMPTY = _PersistentSequenceBase.EMPTY;
  
  factory ImmutableSequence.from(final Iterable<E> elements) =>
    (elements is _PersistentSequenceBase) ? elements :
      elements.fold(EMPTY,
          (final _PersistentSequenceBase<E> accumulator, final E element) => 
              accumulator.add(element));
  
  int get hashCode;
  
  bool operator==(other);
  
  ImmutableSequence<E> add(E value);
  
  ImmutableSequence<E> addAll(Iterable<E> elements);  
  
  ImmutableSequence<E> remove(E element);
  
  ImmutableSequence<E> get tail;    
  
  ImmutableSequence<E> push(E value);
  
  ImmutableSequence<E> insertAll(final Iterable<Pair<int, E>> other);
  
  ImmutableSequence<E> insert(final int key, final E value);
  
  ImmutableSequence<E> insertPair(final Pair<int,E> pair);
  
  ImmutableSequence<E> removeAt(final int key);
}

abstract class _ImmutableSequenceBase<E> extends IterableBase<E> implements ImmutableSequence<E> {
  const _ImmutableSequenceBase();
  
  E get first =>
      isEmpty ? throw new StateError("List is empty") : this.elementAt(0);
  
  bool get isEmpty =>
      length == 0;    
      
  int get hashCode =>
      computeHashCode(this);
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  // FIXME:
  Iterable<int> get keys =>
      new List.generate(length, 
          (final int index) => index);
  
  Iterable<E> get values => this;
  
  E get last =>
      isEmpty ? throw new StateError("List is empty") : this.elementAt(length - 1);    
  
  // rseq
  Iterable<E> get reversed =>
      new  _ReverseSequence(this);
  
  E get single =>
      (length == 1) ? this.elementAt(0) : throw new StateError("List has $length elements");
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSequence) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  List<E> asList() =>
      new _SequenceAsList(this);
  
  bool containsKey(final int key) =>
      (key >= 0) && (key < length);
  
  bool containsValue(final E value) =>
      contains(value);
  
  int indexOf(E element, [int start=0]) {
    checkNotNull(element);
    for (int i = start; i < length; i++) {
      if (this.elementAt(i) == element) {
        return i;
      }
    }
    return -1;
  }
  
  ImmutableSequence<E> insertPair(final Pair<int,E> pair) =>
      insert(pair.fst, pair.snd);  
 
  ImmutableSequence<E> push(final E element) =>
      add(element);
  
  ImmutableSequence<E> pushAll(final Iterable<E> elements) =>
      addAll(elements);
  
  ImmutableSequence<E> remove(final E element) =>
      removeAt(indexOf(element));
  
  Sequence subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
  
  String toString() =>
      "[${join(", ")}]";
}