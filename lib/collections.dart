library restlib.common.collections;

import "dart:collection";
import "dart:math";
import "dart:typed_data";

import "package:collection/wrappers.dart";

import "objects.dart";
import "preconditions.dart";

part "src/collections/array.dart";
part "src/collections/copy_on_write_bimap.dart";
part "src/collections/copy_on_write_collection.dart";
part "src/collections/copy_on_write_dictionary.dart";
part "src/collections/copy_on_write_multimap.dart";
part "src/collections/copy_on_write_multimap_multiset.dart";
part "src/collections/copy_on_write_multimap_sequence.dart";
part "src/collections/copy_on_write_multimap_set.dart";
part "src/collections/copy_on_write_multiset.dart";
part "src/collections/copy_on_write_sequence.dart";
part "src/collections/copy_on_write_set.dart";
part "src/collections/dictionary.dart";
part "src/collections/either.dart";
part "src/collections/forwarding_associative.dart";
part "src/collections/forwarding_bimap.dart";
part "src/collections/forwarding_dictionary.dart";
part "src/collections/forwarding_iterable.dart";
part "src/collections/forwarding_multimap.dart";
part "src/collections/forwarding_multiset.dart";
part "src/collections/forwarding_sequence.dart";
part "src/collections/forwarding_set.dart";
part "src/collections/forwarding_stack.dart";
part "src/collections/immutable.dart";
part "src/collections/immutable_associative.dart";
part "src/collections/immutable_bimap.dart";
part "src/collections/immutable_collection.dart";
part "src/collections/immutable_dictionary.dart";
part "src/collections/immutable_multimap.dart";
part "src/collections/immutable_multimap_multiset.dart";
part "src/collections/immutable_multimap_sequence.dart";
part "src/collections/immutable_multimap_set.dart";
part "src/collections/immutable_multiset.dart";
part "src/collections/immutable_sequence.dart";
part "src/collections/immutable_set.dart";
part "src/collections/immutable_stack.dart";
part "src/collections/iterables.dart";
part "src/collections/multimap.dart";
part "src/collections/mutable_associative.dart";
part "src/collections/mutable_bimap.dart";
part "src/collections/mutable_collection.dart";
part "src/collections/mutable_dictionary.dart";
part "src/collections/mutable_dictionary_map.dart";
part "src/collections/mutable_multimap.dart";
part "src/collections/mutable_multimap_multiset.dart";
part "src/collections/mutable_multimap_sequence.dart";
part "src/collections/mutable_multimap_set.dart";
part "src/collections/mutable_multiset.dart";
part "src/collections/mutable_sequence.dart";
part "src/collections/mutable_sequence_fixed.dart";
part "src/collections/mutable_sequence_growable.dart";
part "src/collections/mutable_set.dart";
part "src/collections/option.dart";
part "src/collections/option_array.dart";
part "src/collections/pair.dart";
part "src/collections/persistent_bimap.dart";
part "src/collections/persistent_dictionary.dart";
part "src/collections/persistent_multimap.dart";
part "src/collections/persistent_multimap_multiset.dart";
part "src/collections/persistent_multimap_sequence.dart";
part "src/collections/persistent_multimap_set.dart";
part "src/collections/persistent_multiset.dart";
part "src/collections/persistent_sequence.dart";
part "src/collections/persistent_set.dart";
part "src/collections/persistent_stack.dart";
part "src/collections/sequence.dart";
part "src/collections/set.dart";

const List EMPTY_LIST = const [];

abstract class Associative<K,V> {
  Iterable<K> get keys;
  Iterable<V> get values;
  
  Iterable<V> operator[](K key);
  
  bool containsKey(K key);
  bool containsValue(V value);
  
  Associative<K,dynamic> mapValues(mapFunc(V value));
}

abstract class BiMap<K,V> implements Dictionary<K,V> {  
  BiMap<V,K> get inverse;
}

abstract class Dictionary<K,V> implements Associative<K,V>, Iterable<Pair<K,V>>{
  factory Dictionary.wrapMap(final Map<K,V> map) =>
      new _MapAsDictionary(map);
  
  Option<V> operator[](K key);
  
  Map<K,V> asMap();
  
  Dictionary<K, dynamic> mapValues(mapFunc(V value));
}

abstract class FiniteSet<E> implements Iterable<E> {
  FiniteSet<E> difference(FiniteSet<E> other);
  FiniteSet<E> intersection(FiniteSet<E> other);
  FiniteSet<E> union(FiniteSet<E> other);
}

abstract class Multimap<K,V, I extends Iterable<V>> implements Associative<K,V>, Iterable<Pair<K,V>> {  
  Dictionary<K, I> get dictionary;
  I operator[](K key);
  
  Multimap<K, dynamic, dynamic> mapValues(mapFunc(V value));
}

abstract class SequenceMultimap<K,V> implements Multimap<K,V,Sequence<V>> {
  Dictionary<K, Sequence<V>> get dictionary;
}

abstract class MultisetMultimap<K,V> implements Multimap<K,V,Multiset<V>> {
  Dictionary<K, Multiset<V>> get dictionary;
}

abstract class SetMultimap<K,V> implements Multimap<K,V,FiniteSet<V>> {
  Dictionary<K, FiniteSet<V>> get dictionary;
}

abstract class Multiset<E> implements Iterable<E> {
  Iterable<E> get elements;
  Dictionary<E, int> get entries;
  
  int count(E element);
}

abstract class Sequence<E> implements Associative<int, E>, Iterable<E> {
  Sequence<E> get reversed;
  
  Option<E> operator[](int index);
  
  int indexOf(E element, [int start=0]);
  
  Sequence<E> subSequence(int start, int length);
  
  List<E> asList();
  
  Sequence mapValues(mapFunc(E value));
}

abstract class Stack<E> implements Iterable<E> {
  Stack<E> get tail;
}
