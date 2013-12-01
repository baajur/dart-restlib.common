part of restlib.common.collections;

abstract class PersistentSequence<E> implements Sequence<E>, PersistentCollection<E>, PersistentStack<E>, PersistentAssociative<int, E> {
  static const PersistentSequence EMPTY = _PersistentSequenceBase.EMPTY;
  
  factory PersistentSequence.from(final Iterable<E> elements) =>
    (elements is _PersistentSequenceBase) ? elements :
      elements.fold(EMPTY,
          (final _PersistentSequenceBase<E> accumulator, final E element) => 
              accumulator.add(element));
  
  PersistentSequence<E> add(E value);
  
  PersistentSequence<E> addAll(Iterable<E> elements);  
  
  PersistentSequence<E> remove(E element);
  
  PersistentSequence<E> get tail;    
  
  PersistentSequence<E> push(E value);
  
  PersistentSequence<E> insertAll(final Iterable<Pair<int, E>> other);
  
  PersistentSequence<E> insert(final int key, final E value);
  
  PersistentSequence<E> insertPair(final Pair<int,E> pair);
  
  PersistentSequence<E> removeAt(final int key);
}

class _PersistentSequenceBase<E> extends IterableBase<E> implements PersistentSequence<E> {
  static const PersistentSequence EMPTY = const _PersistentSequenceBase._internal(0, 5, _EMPTY_ARRAY_32, Array.EMPTY);
  
  static const Array _EMPTY_ARRAY_32 = 
      const Array.wrap(const [null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null]);
  
  final int length;
  final int _shift;
  final Array _root;
  final Array _tail;
  
  const _PersistentSequenceBase._internal(this.length, this._shift, this._root, this._tail);
  
  E get first =>
      isEmpty ? throw new StateError("List is empty") : this.elementAt(0);
  
  int get hashCode =>
      computeHashCode(this);
      
  bool get isEmpty =>
      length == 0;
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
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
      (length == 1) ? elementAt(0) : throw new StateError("List has $length elements");
  
  // pop
  PersistentSequence<E> get tail {
    if (length == 0) {
      throw new StateError("Empty list does not have a tail.");
    } else if (length == 1) {
      return EMPTY;
    } else if (length - _tailoff() > 1) {
      final Array newTail = new Array.ofSize(_tail.length - 1)..setAll(0, _tail.subArray(0, _tail.length - 1));
      return new _PersistentSequenceBase._internal(length - 1, _shift, _root, newTail);
    } else {
      final Array newtail = _arrayFor(length - 2);
      Array newroot = firstNotNull(_popTail(_shift, _root), Array.EMPTY);
      int newshift = _shift;
 
      if (_shift > 5 && isNull(newroot[1])) {
        newroot = newroot[0];
        newshift -= 5;
      }
    
      return new _PersistentSequenceBase._internal(length - 1, newshift, newroot, newtail);
    }
  }
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if ((other is Sequence) && (other is Immutable)) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  // nth
  Option<E> operator[](final int index) {
    if(index >= 0 && index < length) {
      final Array node = _arrayFor(index);
      return new Option(node[index & 0x01f]);
    }
    return Option.NONE;
  }
  
  // cons
  PersistentSequence<E> add(final E element) {
    checkNotNull(element);
    
    // room in tail?
    if (length - _tailoff() < 32) {
      final Array newTail = 
          new Array.ofSize(_tail.length + 1)
            ..setAll(0, _tail)
            ..[_tail.length] = element;
      return new _PersistentSequenceBase._internal(length + 1, _shift, _root, newTail);
    } else {
      //full tail, push into tree
      Array newroot;
      final Array tailnode = _tail;
      int newshift = _shift;
      
      // overflow root?
      if ((length >> 5) > (1 << _shift)) {
        newroot = 
            new Array.ofSize(32)
              ..[0] = _root
              ..[1] = _newPath(_shift, tailnode);
        newshift += 5;
      } else {
        newroot = _pushTail(_shift, _root, tailnode);
      }
      return new _PersistentSequenceBase._internal(length + 1, newshift, newroot, new Array.ofSize(1)..[0] = element);
    }
  }
  
  PersistentSequence<E> addAll(final Iterable<E> elements) =>
      elements.fold(this, (final _PersistentSequenceBase<E> accumulator, final E element) => 
          accumulator.add(element));
  
  List<E> asList() =>
      new _SequenceAsList(this);
  
  bool containsKey(final int key) =>
      (key >= 0) && (key < length);
  
  bool containsValue(final E value) =>
      contains(value);
  
  E elementAt(final int index) {
    if(index >= 0 && index < length) {
      final Array node = _arrayFor(index);
      return node[index & 0x01f];
    }
    throw new RangeError.range(index, 0, length - 1);
  }       
  
  int indexOf(E element, [int start=0]) {
    checkNotNull(element);
    for (int i = start; i < length; i++) {
      if (elementAt(i) == element) {
        return i;
      }
    }
    return -1;
  }
  
  // assocN
  PersistentSequence<E> insert(final int index, final E element) {
    checkNotNull(element);
    
    if (index >= 0 && index < length) {
      if (index >= _tailoff()) {
        final Array newTail = new Array.ofSize(_tail.length)..setAll(0, _tail)..[index & 0x01f] = element;
        return new _PersistentSequenceBase._internal(length, _shift, _root, newTail);
      } else {
        return new _PersistentSequenceBase._internal(length, _shift, _doInsert(_shift, _root, index, element), _tail);
      }
    } else if(index == length) {
      return add(element);
    }
    
    throw new RangeError.value(index);
  }
  
  PersistentSequence<E> insertPair(final Pair<int,E> pair) =>
      insert(pair.fst, pair.snd);
  
  PersistentSequence<E> insertAll(final Iterable<Pair<int, E>> pairs) =>
      pairs.fold(this, 
          (final PersistentSequence<E> accumulator, final Pair<int, E> pair) => 
              accumulator.insert(pair.fst, pair.snd));
 
  PersistentSequence<E> push(final E element) =>
      add(element);
  
  PersistentSequence<E> pushAll(final Iterable<E> elements) =>
      addAll(elements);
  
  PersistentSequence<E> remove(final E element) =>
      removeAt(indexOf(element));
  
  // FIXME: Performance?
  PersistentSequence<E> removeAt(final int key) {
    checkRangeInclusive(key, 0, length);
    PersistentSequence<E> retval = this;
    
    for (int i = length; i > key; i--) {
      retval = retval.tail;
    }
    
    for (int i = (key + 1); i < length; i++) {
      retval = retval.add(elementAt(i));
    }
    
    return retval;
  }
  
  Sequence subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
  
  String toString() =>
      "[${join(", ")}]";
  
  Array _arrayFor(final int index) {
    if (index >= _tailoff()) {
      return _tail;
    } else {
      Array node = _root;
    
      for(int level = _shift; level > 0; level -= 5) {
        node = node[(index >> level) & 0x01f];
      }
      return node;
    }
  }
  
  static Array _doInsert(final int level, final Array node, final int index, final Object object){
    final Array ret = node.copy();
    
    if (level == 0) {
      ret[index & 0x01f] = object;
    } else {
      final int subidx = (index >> level) & 0x01f;
      ret[subidx] = _doInsert(level - 5, node[subidx], index, object);
    }
    
    return ret;
  }
  
  static Array _newPath(final int level, final Array node) {
    if (level == 0) {
      return node;
    } else {
      final Array ret = new Array.ofSize(32);
      ret[0] = _newPath(level - 5, node);
      return ret;
    }
  }
  
  Array _popTail(final int level, final Array node) {
    final int subidx = ((length-2) >> level) & 0x01f;
    
    if (level > 5) {
      final Array newchild = _popTail(level - 5, node[subidx]);  
      return (isNull(newchild) && subidx == 0) ? null : node.toList(growable: false)..[subidx] = newchild;
    } else if (subidx == 0) {
      return null;
    } else {
      return node.copy()..[subidx] = null;
    }
}
  
  Array _pushTail(final int level, final Array parent, final Array tailnode) {
    //if parent is leaf, insert node,
    // else does it map to an existing child? -> nodeToInsert = pushNode one more level
    // else alloc new path
    //return  nodeToInsert placed in copy of parent
    final int subidx = ((length - 1) >> level) & 0x01f;
    final Array nodeToInsert =
        (level == 5) ? tailnode :
          isNotNull(parent[subidx]) ? 
              _pushTail(level-5, parent[subidx], tailnode) : 
                _newPath(level-5, tailnode);
    
    return parent.copy()..[subidx] = nodeToInsert;
  }
  
  int _tailoff(){
    return (length < 32) ? 0 : ((length - 1) >> 5) << 5;
  }
}