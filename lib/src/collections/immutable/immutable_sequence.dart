part of collections.immutable;

abstract class ImmutableSequence<E> implements Sequence<E>, ImmutableCollection<E>, ImmutableStack<E>, ImmutableAssociative<int, E> {    
  int get hashCode;
  
  bool operator==(other);
  
  ImmutableSequence<E> add(E value);
  
  ImmutableSequence<E> addAll(Iterable<E> elements);  
  
  Option<E> call(final int key);
  
  ImmutableSequence<E> remove(E element);
  
  ImmutableSequence<E> get tail;    
  
  ImmutableSequence<E> push(E value);
  
  ImmutableSequence<E> pushAll(final Iterable<E> other);
  
  ImmutableSequence<E> putAll(final Iterable<Pair<int, E>> other);
  
  ImmutableSequence<E> putAllFromMap(final Map<int,E> map);
  
  ImmutableSequence<E> put(final int key, final E value);
  
  ImmutableSequence<E> putPair(final Pair<int,E> pair);
  
  ImmutableSequence<E> removeAt(final int key);
  
  ImmutableSequence<E> subSequence(int start, int length);
}

abstract class _ImmutableSequenceBase<E> extends SequenceBase<E> implements ImmutableSequence<E> {
  const _ImmutableSequenceBase();
  
  int get hashCode =>
      computeHashCode(this);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSequence) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  ImmutableSequence<E> addAll(final Iterable<E> elements) {
    if (this.isEmpty && elements is ImmutableSequence) {
      return elements;
    } else {
      return elements.fold(this, (final ImmutableSequence<E> accumulator, final E element) => 
          accumulator.add(element));
    }
  }
  
  E elementAt(final int index) {
    if(index >= 0 && index < length) {
      return this[index].value;
    }
    throw new RangeError.range(index, 0, length - 1);
  } 
  
  ImmutableSequence<E> putPair(final Pair<int,E> pair) =>
      put(pair.fst, pair.snd);  
 
  ImmutableSequence<E> push(final E element) =>
      add(element);
  
  ImmutableSequence<E> pushAll(final Iterable<E> elements) =>
      addAll(elements);
  
  ImmutableSequence<E> putAll(final Iterable<Pair<int, E>> pairs) =>
      pairs.fold(this, 
          (final ImmutableSequence<E> accumulator, final Pair<int, E> pair) => 
              accumulator.put(pair.fst, pair.snd));
  
  ImmutableSequence<E> putAllFromMap(final Map<int,E> map) {
    ImmutableSequence<E> result = this;
    map.forEach((final int k,final E v) => 
        result = result.put(k, v));
    return result;
  }
  
  ImmutableSequence<E> remove(final E element) =>
      removeAt(indexOf(element));
  
  // FIXME: Performance?
  ImmutableSequence<E> removeAt(final int key) {
    checkRangeInclusive(key, 0, length);
    ImmutableSequence<E> retval = this;
    
    for (int i = length; i > key; i--) {
      retval = retval.tail;
    }
    
    for (int i = (key + 1); i < length; i++) {
      retval = retval.add(elementAt(i));
    }
    
    return retval;
  }

  ImmutableSequence<E> subSequence(int start, int length) {
    checkArgument(start + length <= this.length);
    
    if (this is _ImmutableSubSequence) {
      final _ImmutableSubSequence self = this;
      return new _ImmutableSubSequence(self.delegate, self.start + start, length);   
    }
    
    return new _ImmutableSubSequence(this, start, length);
  }
}

class _ImmutableSubSequence<E> extends _ImmutableSequenceBase<E> implements ImmutableSequence<E> {
  final ImmutableSequence delegate;
  final int start;
  final int length;
  
  _ImmutableSubSequence(this.delegate, this.start, this.length);
  
  Iterator<E> get iterator =>
      delegate.skip(start).take(length).iterator;
  
  ImmutableSequence<E> get tail {
    if ((length - 1) == 0) {
      return EMPTY_SEQUENCE;
    }
    return new _ImmutableSubSequence(this.delegate, this.start, this.length - 1);
  }
  
  Option<E> operator[](final int index) {
    checkIndex(index);
    return delegate[start + index];
  }
  
  checkIndex(final int index) =>
      checkArgument((start + index) < (length + start));
  
  ImmutableSequence<E> put(final int index, final E element) {
    checkIndex(index);
    
    if((start + index) == (start + length)) {
      return add(element);
    } else {
      return new _ImmutableSubSequence(
          this.delegate.put(start + index, element), 
              this.start,
              this.length);
    }
  }
  
  ImmutableSequence<E> add(final E element) =>
      new _ImmutableSubSequence(
          this.delegate.put(start + length, element),
          start,
          length + 1);
}