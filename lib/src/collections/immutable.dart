part of restlib.common.collections;

abstract class Persistent {
  static const ImmutableBiMap EMPTY_BIMAP = _PersistentBiMap.EMPTY;
  static const ImmutableDictionary EMPTY_DICTIONARY = _PersistentDictionary.EMPTY;
  static const ImmutableMultisetMultimap EMPTY_MULTISET_MULTIMAP = _PersistentMultisetMultimapBase.EMPTY;
  static const ImmutableSequenceMultimap EMPTY_SEQUENCE_MULTIMAP = _PersistentSequenceMultimapBase.EMPTY;
  static const ImmutableSetMultimap EMPTY_SET_MULTIMAP = _PersistentSetMultimapBase.EMPTY;
  static const ImmutableMultiset EMPTY_MULTISET = _PersistentMultisetBase.EMPTY;
  static const ImmutableSequence EMPTY_SEQUENCE = _PersistentSequence.EMPTY;
  static const ImmutableSet EMPTY_SET = _PersistentSetBase.EMPTY;
  static const ImmutableStack EMPTY_STACK = _PersistentStack.EMPTY;
}

abstract class CopyOnWrite {}