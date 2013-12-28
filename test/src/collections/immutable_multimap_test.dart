part of restlib.common.collections_test;

void immutableMultisetMultimapTests() { 
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET_MULTIMAP,
       CopyOnWrite.EMPTY_MULTISET_MULTIMAP
      ])
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       Persistent.EMPTY_MULTISET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       CopyOnWrite.EMPTY_MULTISET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       (new CopyOnWriteMultisetMultimapBuilder()..insert("a", "a")..insert("a", "b")..insert("c", "d")).build()
      ])
  ..executeTestCase();
  
  group("copyonwrite", () =>
      new ImmutableMultisetMultimapTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteMultisetMultimapBuilder()
              ..insertAll(new List.generate(size, (i) => new Pair(i,i)))
            ).build())
        ..insertCount = 10
        ..insertAllCount = 10
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableMultisetMultimap());
  
  group("persistent", () =>
      new ImmutableMultisetMultimapTester()
          ..generator = ((final int size) => 
              Persistent.EMPTY_MULTISET_MULTIMAP.insertAll(new List.generate(size, (i) => new Pair(i,i))))
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
      [Persistent.EMPTY_SEQUENCE_MULTIMAP,
       CopyOnWrite.EMPTY_SEQUENCE_MULTIMAP
      ])
  ..addEqualityGroup(
      [Persistent.EMPTY_SEQUENCE_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       Persistent.EMPTY_SEQUENCE_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       CopyOnWrite.EMPTY_SEQUENCE_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       (new CopyOnWriteSequenceMultimapBuilder()..insert("a", "a")..insert("a", "b")..insert("c", "d")).build()
      ])
  ..executeTestCase();
  
  group("copyonwrite", () =>
      new ImmutableSequenceMultimapTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteSequenceMultimapBuilder()
              ..insertAll(new List.generate(size, (i) => new Pair(i,i)))
            ).build())
        ..insertCount = 10
        ..insertAllCount = 10
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableSequenceMultimap());
  
  group("persistent", () =>
      new ImmutableSequenceMultimapTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_SEQUENCE_MULTIMAP.insertAll(new List.generate(size, (i) => new Pair(i,i))))
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
      [Persistent.EMPTY_SET_MULTIMAP,
       CopyOnWrite.EMPTY_SET_MULTIMAP
      ])
  ..addEqualityGroup(
      [Persistent.EMPTY_SET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       Persistent.EMPTY_SET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       CopyOnWrite.EMPTY_SET_MULTIMAP.insert("a", "a").insert("a", "b").insert("c", "d"),
       (new CopyOnWriteSetMultimapBuilder()..insert("a", "a")..insert("a", "b")..insert("c", "d")).build()
      ])
  ..executeTestCase();
  
  group("copyonwrite", () =>
      new ImmutableSetMultimapTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteSetMultimapBuilder()
              ..insertAll(new List.generate(size, (i) => new Pair(i,i)))
            ).build())
        ..insertCount = 10
        ..insertAllCount = 10
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableSetMultimap());
  
  group("persistent", () =>
      new ImmutableSetMultimapTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_SET_MULTIMAP.insertAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertCount = 1000
        ..insertAllCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableSetMultimap());
}