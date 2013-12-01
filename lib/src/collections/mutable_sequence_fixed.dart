part of restlib.common.collections;

abstract class MutableFixedSizeSequence<E> implements MutableSequence<E> {
  static MutableFixedSizeSequence<double> newFloat32Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Float32List(size));
  
  static MutableFixedSizeSequence<Float32x4> newFloat32x4Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Float32x4List(size));
  
  static MutableFixedSizeSequence<double> newFloat64Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Float64List(size));
  
  static MutableFixedSizeSequence<int> newInt16Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Int16List(size));
  
  static MutableFixedSizeSequence<int> newInt32Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Int32List(size));
  
  static MutableFixedSizeSequence<Int32x4> newInt32x4Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Int32x4List(size));
  
  static MutableFixedSizeSequence<int> newInt64Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Int64List(size));
  
  static MutableFixedSizeSequence<int> newInt8Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Int8List(size));
  
  static MutableFixedSizeSequence<int> newUint16Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Uint16List(size));
  
  static MutableFixedSizeSequence<int> newUint32Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Uint32List(size));
  
  static MutableFixedSizeSequence<int> newUint64Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Uint64List(size));
  
  static MutableFixedSizeSequence<int> newUint8ClampedSequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Uint8ClampedList(size));
  
  static MutableFixedSizeSequence<int> newUint8Sequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new Uint8List(size));
  
  factory MutableFixedSizeSequence(final int size) =>
      new _MutableFixedSizeSequenceBase._internal(new List<E>(size));
  
  int get size;
}

class _MutableFixedSizeSequenceBase<E> extends _AbstractMutableSequence<E> implements MutableFixedSizeSequence<E> {
  int _length = 0;
    
  _MutableFixedSizeSequenceBase._internal(final List<E> delegate) : super(delegate);
  
  bool get isEmpty => 
      _length == 0;
  
  Iterator<E> get iterator =>
      delegate.take(_length).iterator;
  
  int get length => 
      _length;
  
  int get size =>
      delegate.length;
  
  void operator[]=(final int index, final E value) {
    checkArgument(index >= 0);
    checkNotNull(value);
    
    if (index >= 0 && index < length) {
      delegate[index] = value;
    } else if (index == length) {
      add(value);
    } else {
      throw new RangeError.value(index);
    }
  }
  
  void add(final E element) {
    checkNotNull(element);
    
    if (length < size) {
      delegate[length] = element;
      _length++;
    } else {
      throw new RangeError.value(length);
    }
  }
  
  void clear() {
      _length = 0;
  }
      
  Option<E> remove(E element) {
    final int indexOfE = delegate.indexOf(element);
    
    if(indexOfE > -1) {
      _length--;
      
      for(int i = indexOfE; i < (delegate.length - 1); i++) {
        delegate[i] = delegate[i + 1];
        
      }
      delegate[delegate.length - 1] = null;
      
      return new Option(element);
    } 
    
    return Option.NONE;
  }
  
  E removeAt(int index) {
    checkArgument(index >= 0);
    
    if (index < _length) {
      final E retVal = 
      _length--;
      
      for(int i = index; i < (delegate.length - 1); i++) {
        delegate[i] = delegate[i + 1];
      }
      
    } else {
      throw new RangeError.value(length);
    }
  }
  
  String toString() => 
      delegate.take(_length).toList().toString();
}