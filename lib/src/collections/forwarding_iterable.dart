part of restlib.common.collections;

class ForwardingIterable<E> implements Iterable<E> {
  final Iterable<E> _delegate;
  
  ForwardingIterable(final Iterable<E> delegate) :
    this._delegate = checkNotNull(delegate);
  
  Iterable map(f(E element)) => _delegate.map(f);

  Iterable<E> where(bool f(E element)) => _delegate.where(f);
      
  Iterable expand(Iterable f(E element)) => _delegate.expand(f);

  bool contains(E element) => _delegate.contains(element);

  void forEach(void f(E element)) => _delegate.forEach(f);

  E reduce(E combine(E value, E element)) => _delegate.reduce(combine);

  dynamic fold(var initialValue,
               dynamic combine(var previousValue, E element)) =>
                   _delegate.fold(initialValue, combine);

  bool every(bool f(E element)) => _delegate.every(f);

  String join([String separator]) => _delegate.join(separator);

  bool any(bool f(E element)) => _delegate.any(f);

  List<E> toList({ bool growable: true }) => _delegate.toList(growable: growable);

  Set<E> toSet() => _delegate.toSet();

  Iterator<E> get iterator => _delegate.iterator;
  
  int get length => _delegate.length;

  bool get isEmpty => _delegate.isEmpty;

  bool get isNotEmpty => _delegate.isNotEmpty;

  Iterable<E> take(int n) => _delegate.take(n);

  Iterable<E> takeWhile(bool test(E value)) => _delegate.takeWhile(test);

  Iterable<E> skip(int n) => _delegate.skip(n);

  Iterable<E> skipWhile(bool test(E value)) => _delegate.skipWhile(test);

  E get first => _delegate.first;

  E get last => _delegate.last;

  E get single => _delegate.single;

  E firstWhere(bool test(E value), { E orElse() }) => _delegate.firstWhere(test, orElse: orElse);

  E lastWhere(bool test(E value), {E orElse()}) => _delegate.lastWhere(test, orElse: orElse);

  E singleWhere(bool test(E value)) => _delegate.singleWhere(test);

  E elementAt(int index) => _delegate.elementAt(index);
}