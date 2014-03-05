library collections.immutable;

import "dart:collection";

import "collections.dart";
import "collections.internal.dart";
import "objects.dart";
import "preconditions.dart";

part "src/collections/immutable/immutable_associative.dart";
part "src/collections/immutable/immutable_bimap.dart";
part "src/collections/immutable/immutable_collection.dart";
part "src/collections/immutable/immutable_dictionary.dart";
part "src/collections/immutable/immutable_multimap.dart";
part "src/collections/immutable/immutable_multimap_multiset.dart";
part "src/collections/immutable/immutable_multimap_sequence.dart";
part "src/collections/immutable/immutable_multimap_set.dart";
part "src/collections/immutable/immutable_multiset.dart";
part "src/collections/immutable/immutable_sequence.dart";
part "src/collections/immutable/immutable_set.dart";
part "src/collections/immutable/immutable_stack.dart";
part "src/collections/immutable/persistent_bimap.dart";
part "src/collections/immutable/persistent_dictionary.dart";
part "src/collections/immutable/persistent_multimap.dart";
part "src/collections/immutable/persistent_multimap_multiset.dart";
part "src/collections/immutable/persistent_multimap_sequence.dart";
part "src/collections/immutable/persistent_multimap_set.dart";
part "src/collections/immutable/persistent_multiset.dart";
part "src/collections/immutable/persistent_sequence.dart";
part "src/collections/immutable/persistent_set.dart";
part "src/collections/immutable/persistent_stack.dart";

const ImmutableBiMap EMPTY_BIMAP = _PersistentBiMap.EMPTY;
const ImmutableDictionary EMPTY_DICTIONARY = _PersistentDictionary.EMPTY;
const ImmutableMultisetMultimap EMPTY_MULTISET_MULTIMAP = _PersistentMultisetMultimapBase.EMPTY;
const ImmutableSequenceMultimap EMPTY_SEQUENCE_MULTIMAP = _PersistentSequenceMultimapBase.EMPTY;
const ImmutableSetMultimap EMPTY_SET_MULTIMAP = _PersistentSetMultimapBase.EMPTY;
const ImmutableMultiset EMPTY_MULTISET = _PersistentMultisetBase.EMPTY;
const ImmutableSequence EMPTY_SEQUENCE = _PersistentSequence.EMPTY;
const ImmutableSet EMPTY_SET = _PersistentSetBase.EMPTY;
const ImmutableStack EMPTY_STACK = _PersistentStack.EMPTY;