part of restlib.common.collections_test;

immutableDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_DICTIONARY,
       EMPTY_DICTIONARY.put("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [EMPTY_DICTIONARY.put("a", "a").put("b", "b"),
       EMPTY_DICTIONARY.put("b", "b").put("a", "a"),
       EMPTY_DICTIONARY.putAllFromMap({"a" : "a", "b" : "b"}),
       EMPTY_DICTIONARY.put("b", "b").put("c", "c").put("a", "a").removeAt("c"),
      ])
  ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableDictionaryTester()
        ..generator = ((final int size) => 
            EMPTY_DICTIONARY.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertCount = 1000
        ..insertAllCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableDictionary());
}