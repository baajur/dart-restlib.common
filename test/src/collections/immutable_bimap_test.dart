part of restlib.common.collections_test;

immutableBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_BIMAP,
      EMPTY_BIMAP.put("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [EMPTY_BIMAP.put("a", "a").put("b", "b"),
       EMPTY_BIMAP.put("b", "b").put("a", "a"),
       EMPTY_BIMAP.putAllFromMap({"a" : "a", "b" : "b"}),
       EMPTY_BIMAP.put("b", "b").put("c", "c").put("a", "a").removeAt("c"),
      ])
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableBiMapTester()
        ..generator = ((final int size) => 
            EMPTY_BIMAP.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertAllCount = 1000
        ..insertCount = 1000
        ..invalidKey = 1001
        ..removeAtCount = 1000
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableBiMap());
}