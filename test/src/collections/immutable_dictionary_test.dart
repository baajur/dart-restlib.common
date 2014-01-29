part of restlib.common.collections_test;

immutableDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY,
      Persistent.EMPTY_DICTIONARY.put("a", "a").removeAt("a"),
      new CopyOnWriteDictionaryBuilder().build(),
      CopyOnWrite.EMPTY_DICTIONARY])
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY.put("a", "a").put("b", "b"),
       Persistent.EMPTY_DICTIONARY.put("b", "b").put("a", "a"),
       Persistent.EMPTY_DICTIONARY.putAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_DICTIONARY.put("b", "b").put("c", "c").put("a", "a").removeAt("c"),
       CopyOnWrite.EMPTY_DICTIONARY.put("a", "a").put("b", "b"),
       (new CopyOnWriteDictionaryBuilder()..insert("a", "a")..insert("b", "b")).build()
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableDictionaryTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_DICTIONARY.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertCount = 1000
        ..insertAllCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableDictionary());
  
  group("copyonwrite", () => 
      new ImmutableDictionaryTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteDictionaryBuilder()
              ..insertAll(new List.generate(size, (i) => new Pair(i,i))))
              .build())
        ..insertCount = 10
        ..insertAllCount = 10
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableDictionary());
}