library restlib.common.collections;

import "dart:collection";
import "dart:typed_data";

import "objects.dart";
import "preconditions.dart";

part "src/collections/either.dart";
part "src/collections/forwarding_bimap.dart";
part "src/collections/forwarding_dictionary.dart";
part "src/collections/forwarding_iterable.dart";
part "src/collections/forwarding_multimap.dart";
part "src/collections/forwarding_multiset.dart";
part "src/collections/forwarding_sequence.dart";
part "src/collections/forwarding_stack.dart";
part "src/collections/iterables.dart";
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
part "src/collections/pair.dart";
part "src/collections/persistent_associative.dart";
part "src/collections/persistent_bimap.dart";
part "src/collections/persistent_collection.dart";
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

const List EMPTY_LIST = const [];

abstract class Associative<K,V> {
  Iterable<K> get keys;
  Iterable<V> get values;
  
  Iterable<V> operator[](K key);
  
  bool containsKey(K key);
  bool containsValue(V value);
}

abstract class BiMap<K,V> implements Dictionary<K,V> {  
  BiMap<V,K> get inverse;
}

abstract class Dictionary<K,V> implements Associative<K,V>, Iterable<Pair<K,V>>{
  Option<V> operator[](K key);
}

abstract class Multimap<K,V, I extends Iterable<V>> implements Associative<K,V>, Iterable<Pair<K,V>> {  
  Dictionary<K, I> get dictionary;
}

abstract class SequenceMultimap<K,V, I extends Sequence<V>> extends Multimap<K,V,I> {
  
}

abstract class MultisetMultimap<K,V, I extends Multiset<V>> extends Multimap<K,V,I> {
  
}

abstract class Multiset<E> implements Iterable<E> {
  int count(E element);
}

abstract class Sequence<E> implements Associative<int, E>, Iterable<E> {
  Sequence<E> get reversed;
  
  Option<E> operator[](int index);
  
  Sequence<E> subSequence(int start, int length);
}

abstract class Stack<E> implements Iterable<E> {
  Stack<E> get tail;
}
