part of restlib.common.collections_test;

immutableBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP,
      Persistent.EMPTY_BIMAP.insert("a", "a").removeAt("a"),
      CopyOnWrite.EMPTY_BIMAP,
      new CopyOnWriteBiMapBuilder().build()])
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP.insert("a", "a").insert("b", "b"),
       Persistent.EMPTY_BIMAP.insert("b", "b").insert("a", "a"),
       Persistent.EMPTY_BIMAP.insertAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_BIMAP.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c"),
       (new CopyOnWriteBiMapBuilder()..insert("a", "a")..insert("b", "b")).build(),
       CopyOnWrite.EMPTY_BIMAP.insert("a", "a").insert("b", "b"),
      ])
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableBiMapTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_BIMAP.insertAll(new List.generate(size, (i) => new Pair(i,i))))
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