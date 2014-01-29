part of restlib.common.collections_test;

immutableBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP,
      Persistent.EMPTY_BIMAP.put("a", "a").removeAt("a"),
      CopyOnWrite.EMPTY_BIMAP,
      new CopyOnWriteBiMapBuilder().build()])
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP.put("a", "a").put("b", "b"),
       Persistent.EMPTY_BIMAP.put("b", "b").put("a", "a"),
       Persistent.EMPTY_BIMAP.putAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_BIMAP.put("b", "b").put("c", "c").put("a", "a").removeAt("c"),
       (new CopyOnWriteBiMapBuilder()..insert("a", "a")..insert("b", "b")).build(),
       CopyOnWrite.EMPTY_BIMAP.put("a", "a").put("b", "b"),
      ])
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableBiMapTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_BIMAP.putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..insertAllCount = 1000
        ..insertCount = 1000
        ..invalidKey = 1001
        ..removeAtCount = 1000
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableBiMap());
  
  group("copyonwrite", () => 
      new ImmutableBiMapTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteBiMapBuilder()
              ..insertAll(new List.generate(size, (i) => new Pair(i,i))))
              .build())
        ..insertAllCount = 10
        ..insertCount = 10
        ..invalidKey = 1001
        ..removeAtCount = 10
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0,1,10]
        ..testImmutableBiMap());
}