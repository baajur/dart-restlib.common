part of restlib.common.collections;

class Option<E> implements Iterable<E> {
  static const Option NONE = const Option._internal(null);
  
  factory Option(final E value) =>
      value == null ? Option.NONE : new Option._internal(value);
  
  final E _value;
  
  const Option._internal(this._value);
  
  E get first => value;
  
  int get hashCode => _value.hashCode;
  
  bool get isEmpty => _value == null;
  
  bool get isNotEmpty => !isEmpty;
  
  Iterator<E> get iterator => 
      (_value == null) ? EMPTY_LIST.iterator : [_value].iterator;
  
  E get last => value;
  
  int get length => (_value == null) ? 0 : 1;
  
  E get single => value;
  
  E get value {
    if (_value == null) {
      throw new StateError("Option is NONE.");
    }
    return _value;
  }
  
  bool any(bool f(E element)) => 
      (_value == null) ? false : f(_value);
  
  bool contains(final E element) => 
      (_value == null) ? false : _value == element;
  
  E elementAt(final int index) { 
    if (_value == null) {
      throw new RangeError("Option is NONE.");
    } else if (index > 0) {
      throw new RangeError("Only 1 element in Option type.");
    }
    return _value; 
  }
  
  bool every(bool f(E element)) => 
      (_value == null) ? false : f(_value);
  
  Iterable expand(Iterable f(E element)) => 
      (_value == null) ? Option.NONE : f(_value);
  
  E firstWhere(bool test(E value), { E orElse() }) {
    if (_value != null && test(_value)) {
      return _value;
    }
    if (orElse != null) return orElse();
    throw new StateError("No matching element");
  }
  
  Option flatMap(Option f(E element)) =>
      (_value == null) ? Option.NONE : f(_value);
  
  dynamic fold(final initialValue, combine(var previousValue, E element)) => 
      (_value == null) ? initialValue : combine(initialValue, _value);  
  
  void forEach(f(E element)) {
    if (_value != null) { f(_value); };
  }
  
  String join([final String separator]) => 
      (_value == null) ? "" : _value.toString();
  
  E lastWhere(bool test(E value), {E orElse()}) => firstWhere(test, orElse: orElse);
  
  Option map(f(E element)) => 
      (_value == null) ? Option.NONE : new Option(f(_value));
  
  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Option) {
      return this._value == other._value;
    } else {
      return false;
    }
  }
  
  dynamic orCompute(dynamic call()) => computeIfNull(_value, call);

  dynamic orElse(final dynamic alternative) => 
    firstNotNull(_value, alternative);
  
  E reduce(E combine(E value, E element)) {
    if (_value == null) {
      throw new StateError("Option is NONE");
    }
    return _value;
  }
  
  E singleWhere(bool test(E value)) => firstWhere(test);
  
  Option<E> skip(final int n) =>
    (_value == null || n > 0) ? Option.NONE : this;
  
  Option<E> skipWhile(bool test(E value)) => 
      (_value == null || test(_value)) ? Option.NONE : this;
  
  Option<E> take(final int n) => 
      (_value != null && n > 0) ? this : Option.NONE;
  
  Option<E> takeWhile(bool test(E value)) => 
      (_value != null && test(_value)) ? this : Option.NONE;
  
  List<E> toList({ final bool growable: true }) => 
      new List<E>.from(this, growable: growable);
  
  Set<E> toSet() => new Set<E>.from(this);
  
  String toString() =>
      (_value == null) ? "Option.NONE" : "Option($_value)";
  
  Option<E> where(bool f(E element)) => 
      (_value != null && f(_value)) ? this : Option.NONE;
}