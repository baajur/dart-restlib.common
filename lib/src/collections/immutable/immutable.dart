part of restlib.common.collections.immutable;

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

abstract class CopyOnWrite {
  static final ImmutableBiMap EMPTY_BIMAP = _CopyOnWriteBiMap.EMPTY;
  static final ImmutableDictionary EMPTY_DICTIONARY = _CopyOnWriteDictionary.EMPTY;
  static final ImmutableMultisetMultimap EMPTY_MULTISET_MULTIMAP = _CopyOnWriteMultisetMultimap.EMPTY;
  static final ImmutableSequenceMultimap EMPTY_SEQUENCE_MULTIMAP = _CopyOnWriteSequenceMultimap.EMPTY;
  static final ImmutableSetMultimap EMPTY_SET_MULTIMAP = _CopyOnWriteSetMultimap.EMPTY;
  static final ImmutableMultiset EMPTY_MULTISET = _CopyOnWriteMultiset.EMPTY;
  static final ImmutableSequence EMPTY_SEQUENCE = _CopyOnWriteSequence.EMPTY;
  static final ImmutableSet EMPTY_SET = _CopyOnWriteSet.EMPTY;
  //static const ImmutableStack EMPTY_STACK = _PersistentStack.EMPTY;
}