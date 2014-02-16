part of restlib.common.collections_test;

void immutableMultisetMultimapTests() { 
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_MULTISET_MULTIMAP, 
       EMPTY_MULTISET_MULTIMAP
      ])
  ..addEqualityGroup(
      [EMPTY_MULTISET_MULTIMAP.put("a", "a").put("a", "b").put("c", "d"),
       EMPTY_MULTISET_MULTIMAP.put("a", "a").put("a", "b").put("c", "d"),
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableMultisetMultimapTester()
          ..generator = ((final int size) => 
              EMPTY_MULTISET_MULTIMAP.putAll(new List.generate(size, (i) => new Pair(i,i))))
          ..insertCount = 1000
          ..insertAllCount = 1000
          ..invalidKey = 1001
          ..pairGenerator = new SequencePairGenerator()
          ..removeAtCount = 1000
          ..testSizes = [0,1,1000]
        ..testImmutableMultisetMultimap());
}

void immutableSequenceMultimapTests() { 
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_SEQUENCE_MULTIMAP,
       EMPTY_SEQUENCE_MULTIMAP
      ])
  ..addEqualityGroup(
      [EMPTY_SEQUENCE_MULTIMAP.put("a", "a").put("a", "b").put("c", "d"),
       EMPTY_SEQUENCE_MULTIMAP.put("a", "a").put("a", "b").put("c", "d")
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableSequenceMultimapTester()
        ..generator = ((final int size) => 
            EMPTY_SEQUENCE_MULTIMAP.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertCount = 1000
        ..insertAllCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableSequenceMultimap());
}

void immutableSetMultimapTests() { 
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_SET_MULTIMAP,
       EMPTY_SET_MULTIMAP
      ])
  ..addEqualityGroup(
      [EMPTY_SET_MULTIMAP.put("a", "a").put("a", "b").put("c", "d"),
       EMPTY_SET_MULTIMAP.put("a", "a").put("a", "b").put("c", "d"),
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableSetMultimapTester()
        ..generator = ((final int size) => 
            EMPTY_SET_MULTIMAP.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertCount = 1000
        ..insertAllCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableSetMultimap());
}