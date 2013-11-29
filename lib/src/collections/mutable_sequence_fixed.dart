part of restlib.common.collections;

class FixedSizeSequence<E> extends _AbstractMutableSequence<E> implements MutableSequence<E> {
  static FixedSizeSequence<double> newFloat32Sequence(final int size) =>
      new FixedSizeSequence._internal(new Float32List(size));
  
  static FixedSizeSequence<Float32x4> newFloat32x4Sequence(final int size) =>
      new FixedSizeSequence._internal(new Float32x4List(size));
  
  static FixedSizeSequence<double> newFloat64Sequence(final int size) =>
      new FixedSizeSequence._internal(new Float64List(size));
  
  static FixedSizeSequence<int> newInt16Sequence(final int size) =>
      new FixedSizeSequence._internal(new Int16List(size));
  
  static FixedSizeSequence<int> newInt32Sequence(final int size) =>
      new FixedSizeSequence._internal(new Int32List(size));
  
  static FixedSizeSequence<Int32x4> newInt32x4Sequence(final int size) =>
      new FixedSizeSequence._internal(new Int32x4List(size));
  
  static FixedSizeSequence<int> newInt64Sequence(final int size) =>
      new FixedSizeSequence._internal(new Int64List(size));
  
  static FixedSizeSequence<int> newInt8Sequence(final int size) =>
      new FixedSizeSequence._internal(new Int8List(size));
  
  static FixedSizeSequence<int> newUint16Sequence(final int size) =>
      new FixedSizeSequence._internal(new Uint16List(size));
  
  static FixedSizeSequence<int> newUint32Sequence(final int size) =>
      new FixedSizeSequence._internal(new Uint32List(size));
  
  static FixedSizeSequence<int> newUint64Sequence(final int size) =>
      new FixedSizeSequence._internal(new Uint64List(size));
  
  static FixedSizeSequence<int> newUint8ClampedSequence(final int size) =>
      new FixedSizeSequence._internal(new Uint8ClampedList(size));
  
  static FixedSizeSequence<int> newUint8Sequence(final int size) =>
      new FixedSizeSequence._internal(new Uint8List(size));
  
  int _length = 0;
  
  FixedSizeSequence(final int size) : super(new List<E>(size));
  
  FixedSizeSequence._internal(final List<E> delegate) : super(delegate);
  
  bool get isEmpty => 
      _length == 0;
  
  Iterator<E> get iterator =>
      _delegate.take(_length).iterator;
  
  int get length => 
      _length;
  
  int get size =>
      _delegate.length;
  
  void operator[]=(final int index, final E value) {
    checkArgument(index > 0);
    checkNotNull(value);
    
    if (index >= 0 && index < length) {
      (_delegate as List)[index] = value;
    } else if (index == length) {
      add(value);
    } else {
      throw new RangeError.value(index);
    }
  }
  
  void add(final E element) {
    checkNotNull(element);
    
    if (length < size) {
      (_delegate as List)[length] = element;
      _length++;
    } else {
      throw new RangeError.value(length);
    }
  }
  
  bool remove(E element) {
    final int indexOfE = (_delegate as List).indexOf(E);
    
    if(indexOfE > -1) {
      _length--;
      
      for(int i = indexOfE; i < (_delegate.length - 1); i++) {
        (_delegate as List)[i] = (_delegate as List)[i + 1];
      }
      return true;
    } 
    
    return false;
  }
  
  E removeAt(int index) {
    checkArgument(index > 0);
    
    if (index < _length) {
      final E retVal = 
      _length--;
      
      for(int i = index; i < (_delegate.length - 1); i++) {
        (_delegate as List)[i] = (_delegate as List)[i + 1];
      }
      
    } else {
      throw new RangeError.value(length);
    }
  }
  
  String toString() => 
      _delegate.take(_length).toString();
}