library collections;

import "dart:collection";
import "dart:math";

import "package:collection/equality.dart";

import "collections.internal.dart";
import "objects.dart";
import "preconditions.dart";

part "src/collections/array.dart";
part "src/collections/either.dart";
part "src/collections/iterables.dart";
part "src/collections/option.dart";
part "src/collections/tuple.dart";
part "src/collections/tuple_impl.dart";

const List EMPTY_LIST = const [];

abstract class Associative<K,V> {
  Iterable<K> get keys;
  Iterable<V> get values;

  Iterable<V> operator[](K key);

  Iterable<V> call(K key);

  bool containsKey(K key);
  bool containsValue(V value);

  Associative<K,dynamic> mapValues(mapFunc(V value));
}

abstract class BiMap<K,V> implements Dictionary<K,V> {
  BiMap<V,K> get inverse;
}

abstract class Dictionary<K,V> implements Associative<K,V>, Iterable<Pair<K,V>>{
  const factory Dictionary.wrapMap(Map<K,V> map) = MapAsDictionary;

  Option<V> operator[](K key);

  Map<K,V> asMap();

  Option<V> call(K key);

  Dictionary<K,V> filterKeys(bool filterFunc(K key));

  Dictionary<K, dynamic> mapValues(mapFunc(V value));
}

abstract class FiniteSet<E> implements Iterable<E>, Associative<E,E> {
  Option<E> operator[](E key);
  Option<E> call(E key);

  FiniteSet<E> difference(FiniteSet<E> other);
  FiniteSet<E> intersection(FiniteSet<E> other);
  FiniteSet<E> union(FiniteSet<E> other);
}

abstract class Multimap<K,V, I extends Iterable<V>> implements Associative<K,V>, Iterable<Pair<K,V>> {
  Dictionary<K, I> get dictionary;
  I operator[](K key);

  I call(K key);

  Multimap<K,V,I> filterKeys(bool filterFunc(K key));

  Multimap<K, dynamic, dynamic> mapValues(mapFunc(V value));
}

abstract class SequenceMultimap<K,V> implements Multimap<K,V,Sequence<V>> {
  Dictionary<K, Sequence<V>> get dictionary;

  SequenceMultimap<K,V> filterKeys(bool filterFunc(K key));
}

abstract class MultisetMultimap<K,V> implements Multimap<K,V,Multiset<V>> {
  Dictionary<K, Multiset<V>> get dictionary;

  MultisetMultimap<K,V> filterKeys(bool filterFunc(K key));
}

abstract class SetMultimap<K,V> implements Multimap<K,V,FiniteSet<V>> {
  Dictionary<K, FiniteSet<V>> get dictionary;

  SetMultimap<K,V> filterKeys(bool filterFunc(K key));
}

abstract class Multiset<E> implements Iterable<E> {
  Iterable<E> get elements;
  Dictionary<E, int> get entries;

  int count(E element);
}

abstract class Sequence<E> implements Associative<int, E>, Iterable<E> {
  factory Sequence.wrapList(final List<E> delegate) =>
      new ListAsSequence<E>(delegate);

  Sequence<E> get reversed;

  Option<E> operator[](int index);

  Option<E> call(int index);

  int indexOf(E element, [int start=0]);

  Sequence<E> subSequence(int start, int length);

  List<E> asList();

  Sequence mapValues(mapFunc(E value));
}

abstract class Stack<E> implements Iterable<E> {
  Stack<E> get tail;
}
