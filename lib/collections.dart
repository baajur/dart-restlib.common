library restlib.common.collections;

import "dart:collection";
import "dart:math";

import "objects.dart";
import "preconditions.dart";

part "src/collections/either.dart";
part "src/collections/immutable_bimap.dart";
part "src/collections/immutable_list.dart";
part "src/collections/immutable_map.dart";
part "src/collections/immutable_multimap.dart";
part "src/collections/immutable_set.dart";
part "src/collections/iterables.dart";
part "src/collections/option.dart";
part "src/collections/pair.dart";
part "src/collections/persistent_stack.dart";

abstract class Associative<K,V> implements Iterable<Pair<K,V>> {
  Iterable<V> operator[](K key);
  
  bool get isEmpty;
  bool get isNotEmpty;
  Iterable<K> get keys;
}

abstract class Dictionary<K,V> implements Associative<K,V> {
  Option<V> operator[](K key);
}

abstract class BiMap<K,V> implements Dictionary<K,V> {  
  BiMap<V,K> inverse();
}

abstract class Multimap<K,V> implements Associative<K,V> {  
  Dictionary<K, Iterable<V>> asDictionary();
}