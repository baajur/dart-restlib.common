part of restlib.common.collections_test;

immutableDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY,
      Persistent.EMPTY_DICTIONARY.insert("a", "a").removeAt("a"),
      new CopyOnWriteDictionaryBuilder().build()])
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY.insert("a", "a").insert("b", "b"),
       Persistent.EMPTY_DICTIONARY.insert("b", "b").insert("a", "a"),
       Persistent.EMPTY_DICTIONARY.insertAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_DICTIONARY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c"),
       (new CopyOnWriteDictionaryBuilder()
        ..insert("a", "a")
        ..insert("b", "b")).build()
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableDictionaryTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_DICTIONARY.insertAll(new List.generate(size, (i) => new Pair(i,i))))
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