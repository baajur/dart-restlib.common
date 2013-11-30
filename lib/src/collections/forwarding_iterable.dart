part of restlib.common.collections;

abstract class ForwardingIterable<E, D extends Iterable<E>> implements Forwarder<D>, Iterable<E> {  
  Iterable map(f(E element)) => 
      delegate.map(f);

  Iterable<E> where(bool f(E element)) => 
      delegate.where(f);
      
  Iterable expand(Iterable f(E element)) => 
      delegate.expand(f);

  bool contains(final E element) => 
      delegate.contains(element);

  void forEach(void f(E element)) => 
      delegate.forEach(f);

  E reduce(E combine(E value, E element)) => 
      delegate.reduce(combine);

  fold(initialValue, combine(previousValue, E element)) =>
      delegate.fold(initialValue, combine);

  bool every(bool f(E element)) => 
      delegate.every(f);

  String join([final String separator]) => 
      delegate.join(separator);

  bool any(bool f(E element)) => 
      delegate.any(f);

  List<E> toList({ final bool growable: true }) => 
      delegate.toList(growable: growable);

  Set<E> toSet() => 
      delegate.toSet();

  Iterator<E> get iterator => 
      delegate.iterator;
  
  int get length => 
      delegate.length;

  bool get isEmpty => 
      delegate.isEmpty;

  bool get isNotEmpty => 
      delegate.isNotEmpty;

  Iterable<E> take(final int n) => 
      delegate.take(n);

  Iterable<E> takeWhile(bool test(E value)) => 
      delegate.takeWhile(test);

  Iterable<E> skip(final int n) => 
      delegate.skip(n);

  Iterable<E> skipWhile(bool test(E value)) => 
      delegate.skipWhile(test);

  E get first => 
      delegate.first;

  E get last => 
      delegate.last;

  E get single => 
      delegate.single;

  E firstWhere(bool test(E value), { E orElse() }) => 
      delegate.firstWhere(test, orElse: orElse);

  E lastWhere(bool test(E value), {E orElse()}) => 
      delegate.lastWhere(test, orElse: orElse);

  E singleWhere(bool test(E value)) => 
      delegate.singleWhere(test);

  E elementAt(final int index) =>
      delegate.elementAt(index);
}