part of restlib.common.collections;

class PersistentList<E> extends Object with IterableMixin<E> implements Sequence<E>, Stack<E> {
  static final PersistentList EMPTY = new PersistentList._internal(0, 5, new List(32), new List(0));
  
  factory PersistentList.from(final Iterable<E> elements) {
    checkNotNull(elements);
    
    return (elements is PersistentList) ? elements :
      elements.fold(EMPTY,
          (accumulator, E element) => 
              accumulator.add(element));
  }
  
  final int length;
  final int _shift;
  final List _root;
  final List _tail;
  
  PersistentList._internal(this.length, this._shift, this._root, this._tail);
  
  E get first =>
      isEmpty ? throw new StateError("List is empty") : this[0];
  
  int get hashCode =>
      computeHashCode(this);
      
  bool get isEmpty =>
      length == 0;
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  E get last =>
    this[length - 1];    
  
  // rseq
  Iterable<E> get reversed =>
      new  _ReverseSequence(this);
  
  E get single =>
      (length == 1) ? this[0] : throw new StateError("List has $length elements");
  
  // pop
  PersistentList<E> get tail {
    if (length == 0) {
      throw new StateError("Empty list does not have a tail.");
    } else if (length == 1) {
      return EMPTY;
    } else if (length - _tailoff() > 1) {
      List newTail = new List(_tail.length - 1)..setAll(0, _tail);
      return new PersistentList._internal(length - 1, _shift, _root, newTail);
    } else {
      final List newtail = _arrayFor(length - 2);
      List newroot = firstNotNull(_popTail(_shift, _root), new List(0));
      int newshift = _shift;
 
      if (_shift > 5 && isNull(newroot[1])) {
        newroot = newroot[0];
        newshift -= 5;
      }
    
      return new PersistentList._internal(length - 1, newshift, newroot, newtail);
    }
  }
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentList) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  // nth
  Option<E> operator[](final int index) {
    checkNotNull(index);
    
    if(index >= 0 && index < length) {
      List node = _arrayFor(index);
      return new Option(node[index & 0x01f]);
    }
    return Option.NONE;
  }
  
  // cons
  PersistentList<E> add(final E element) {
    checkNotNull(element);
    
    // room in tail?
    if (length - _tailoff() < 32) {
      final List newTail = 
          new List(_tail.length + 1)
            ..setAll(0, _tail)
            ..[_tail.length] = element;
      return new PersistentList._internal(length + 1, _shift, _root, newTail);
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
      return new PersistentList._internal(length + 1, newshift, newroot, new List(1)..[0] = element);
    }
  }
  
  E elementAt(int index) =>
      this[index].orCompute(() => new RangeError.range(index, 0, length - 1));
  
  // assocN
  PersistentList<E> insert(final int index, final E element) {
    checkNotNull(index);
    checkNotNull(element);
    
    if (index >= 0 && index < length) {
      if (index >= _tailoff()) {
        final List newTail = new List(_tail.length)..setAll(0, _tail)..[index & 0x01f] = element;
        return new PersistentList._internal(length, _shift, _root, newTail);
      } else {
        return new PersistentList._internal(length, _shift, _doInsert(_shift, _root, index, element), _tail);
      }
    } else if(index == length) {
      return add(element);
    }
    
    throw new RangeError.value(index);
  }
  
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
  
  static List _doInsert(final int level, final List node, final int index, final E  object){
    final List ret = node.toList(growable: false);
    
    if (level == 0) {
      ret[index & 0x01f] = object;
    } else {
      int subidx = (index >> level) & 0x01f;
      ret[subidx] = _doInsert(level - 5, node[subidx], index, object);
    }
    
    return ret;
  }
  
  static List _newPath(final int level, final List node) {
    if (level == 0) {
      return node;
    } else {
      List ret = new List(32);
      ret[0] = _newPath(level - 5, node);
      return ret;
    }
  }
  
  List _popTail(final int level, final List node) {
    int subidx = ((length-2) >> level) & 0x01f;
    
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

class _SequenceIterator<E> implements Iterator<E> {
  final Sequence<E> _list;
  int _currIndex = -1;
  
  _SequenceIterator(this._list);
  
  E get current => 
      (_currIndex < 0 || _currIndex >= _list.length) ?
          null : _list[_currIndex];

  bool moveNext() =>
      _currIndex + 1 < _list.length; 
}

class _ReverseSequence<E> extends Object with IterableMixin<E> implements Sequence<E> { 
  final Sequence<E> reversed;
  
  _ReverseSequence(this.reversed);
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  int get length =>
      reversed.length;
  
  Option<E> operator[](int index) =>
      reversed[reversed.length - index - 1];
}

class _SubSequence<E> extends Object with IterableMixin<E> implements Sequence<E> { 
  final Sequence<E> delegate;
  final int _start;
  final int length;
  
  _SubSequence(this.delegate, this._start, this.length) {
    checkArgument(_start + length <= delegate.length);
  }
  
  Iterator<E> get iterator =>
      new _SequenceIterator(this);
  
  Sequence<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](int index) =>
      delegate[_start + index];
}