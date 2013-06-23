library restlib.common.collections;

import "dart:collection";
import "dart:math";

import "objects.dart";
import "preconditions.dart";

part "src/collections/either.dart";
part "src/collections/iterables.dart";
part "src/collections/mutable_hash_bimap.dart";
part "src/collections/mutable_hash_map.dart";
part "src/collections/mutable_list.dart";
part "src/collections/option.dart";
part "src/collections/pair.dart";
part "src/collections/persistent_hash_bimap.dart";
part "src/collections/persistent_hash_map.dart";
part "src/collections/persistent_hash_multimap.dart";
part "src/collections/persistent_hash_set.dart";
part "src/collections/persistent_list.dart";
part "src/collections/persistent_stack.dart";

abstract class Associative<K,V> {
  Iterable<V> operator[](K key);
}

abstract class Dictionary<K,V> implements Associative<K,V>, Iterable<Pair<K,V>>{
  Option<V> operator[](K key);
}

abstract class BiMap<K,V> implements Dictionary<K,V> {  
  BiMap<V,K> get inverse;
}

abstract class Multimap<K,V> implements Associative<K,V>, Iterable<Pair<K,V>> {  
  Dictionary<K, Iterable<V>> asDictionary();
}

abstract class Stack<E> implements Iterable<E> {
  Stack<E> get tail;
}

abstract class Sequence<E> implements Associative<int, E>, Iterable<E> {
  Iterable<E> get reversed;
  
  Option<E> operator[](int index);
}