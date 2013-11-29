part of restlib.common.collections;

class PersistentSequence<E> extends IterableBase<E> implements Sequence<E>, Stack<E> {
  static const _EMPTY_LIST_32 = 
      const [null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null,
             null, null, null, null, null, null, null, null];
  
  static const PersistentSequence EMPTY = const PersistentSequence._internal(0, 5, _EMPTY_LIST_32, EMPTY_LIST);
  
  factory PersistentSequence.from(final Iterable<E> elements) =>
    (elements is PersistentSequence) ? elements :
      elements.fold(EMPTY,
          (final PersistentSequence<E> accumulator, final E element) => 
              accumulator.add(element));
  
  final int length;
  final int _shift;
  final List _root;
  final List _tail;
  
  const PersistentSequence._internal(this.length, this._shift, this._root, this._tail);
  
  E get first =>
      isEmpty ? throw new StateError("List is empty") : this.elementAt(0);
  
  int get hashCode =>
      computeHashCode(this);
      
  bool get isEmpty =>
      length == 0;
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
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
      final List newTail = new List(_tail.length - 1)..setAll(0, _tail.sublist(0, _tail.length - 1));
      return new PersistentSequence._internal(length - 1, _shift, _root, newTail);
    } else {
      final List newtail = _arrayFor(length - 2);
      List newroot = firstNotNull(_popTail(_shift, _root), EMPTY_LIST);
      int newshift = _shift;
 
      if (_shift > 5 && isNull(newroot[1])) {
        newroot = newroot[0];
        newshift -= 5;
      }
    
      return new PersistentSequence._internal(length - 1, newshift, newroot, newtail);
    }
  }
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentSequence) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  // nth
  Option<E> operator[](final int index) {
    if(index >= 0 && index < length) {
      final List node = _arrayFor(index);
      return new Option(node[index & 0x01f]);
    }
    return Option.NONE;
  }
  
  // cons
  PersistentSequence<E> add(final E element) {
    checkNotNull(element);
    
    // room in tail?
    if (length - _tailoff() < 32) {
      final List newTail = 
          new List(_tail.length + 1)
            ..setAll(0, _tail)
            ..[_tail.length] = element;
      return new PersistentSequence._internal(length + 1, _shift, _root, newTail);
    } else {
      //full tail, push into tree
      List newroot;
      final List tailnode = _tail;
      int newshift = _shift;
      
      // overflow root?
      if ((length >> 5) > (1 << _shift)) {
        newroot = 
            new List(32)
              ..[0] = _root
              ..[1] = _newPath(_shift, tailnode);
        newshift += 5;
      } else {
        newroot = _pushTail(_shift, _root, tailnode);
      }
      return new PersistentSequence._internal(length + 1, newshift, newroot, new List(1)..[0] = element);
    }
  }
  
  PersistentSequence<E> addAll(final Iterable<E> elements) =>
      elements.fold(this, (final PersistentSequence<E> accumulator, final E element) => 
          accumulator.add(element));
  
  bool containsKey(final int key) =>
      (key >= 0) && (key < length);
  
  E elementAt(final int index) {
    if(index >= 0 && index < length) {
      final List node = _arrayFor(index);
      return node[index & 0x01f];
    }
    throw new RangeError.range(index, 0, length - 1);
  }       
  
  // assocN
  PersistentSequence<E> insert(final int index, final E element) {
    checkNotNull(element);
    
    if (index >= 0 && index < length) {
      if (index >= _tailoff()) {
        final List newTail = new List(_tail.length)..setAll(0, _tail)..[index & 0x01f] = element;
        return new PersistentSequence._internal(length, _shift, _root, newTail);
      } else {
        return new PersistentSequence._internal(length, _shift, _doInsert(_shift, _root, index, element), _tail);
      }
    } else if(index == length) {
      return add(element);
    }
    
    throw new RangeError.value(index);
  }
  
  Sequence subSequence(int start, int length) =>
      new _SubSequence(this, start, length);
  
  String toString() =>
      "[${join(", ")}]";
  
  List _arrayFor(final int index) {
    if (index >= _tailoff()) {
      return _tail;
    } else {
      List node = _root;
    
      for(int level = _shift; level > 0; level -= 5) {
        node = node[(index >> level) & 0x01f];
      }
      return node;
    }
  }
  
  static List _doInsert(final int level, final List node, final int index, final Object object){
    final List ret = node.toList(growable: false);
    
    if (level == 0) {
      ret[index & 0x01f] = object;
    } else {
      final int subidx = (index >> level) & 0x01f;
      ret[subidx] = _doInsert(level - 5, node[subidx], index, object);
    }
    
    return ret;
  }
  
  static List _newPath(final int level, final List node) {
    if (level == 0) {
      return node;
    } else {
      final List ret = new List(32);
      ret[0] = _newPath(level - 5, node);
      return ret;
    }
  }
  
  List _popTail(final int level, final List node) {
    final int subidx = ((length-2) >> level) & 0x01f;
    
    if (level > 5) {
      final List newchild = _popTail(level - 5, node[subidx]);  
      return (isNull(newchild) && subidx == 0) ? null : node.toList(growable: false)..[subidx] = newchild;
    } else if (subidx == 0) {
      return null;
    } else {
      return node.toList(growable: false)..[subidx] = null;
    }
}
  
  List _pushTail(final int level, final List parent, final List tailnode) {
    //if parent is leaf, insert node,
    // else does it map to an existing child? -> nodeToInsert = pushNode one more level
    // else alloc new path
    //return  nodeToInsert placed in copy of parent
    final int subidx = ((length - 1) >> level) & 0x01f;
    final List nodeToInsert =
        (level == 5) ? tailnode :
          isNotNull(parent[subidx]) ? 
              _pushTail(level-5, parent[subidx], tailnode) : 
                _newPath(level-5, tailnode);
    
    return parent.toList(growable: false)..[subidx] = nodeToInsert;
  }
  
  int _tailoff(){
    return (length < 32) ? 0 : ((length - 1) >> 5) << 5;
  }
}