part of restlib.common.collections_test;

void immutableMultisetMultimapTests() { 
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