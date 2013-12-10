part of restlib.common.collections_test;

persistentBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [ImmutableBiMap.EMPTY,
      ImmutableBiMap.EMPTY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [ImmutableBiMap.EMPTY.insert("a", "a").insert("b", "b"),
       ImmutableBiMap.EMPTY.insert("b", "b").insert("a", "a"),
       new ImmutableBiMap.fromMap({"a" : "a", "b" : "b"}),
       ImmutableBiMap.EMPTY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
      ])
  ..executeTestCase();
  

  group("PersistentHashMap.fromMap()", () {
    
  });
  
  group("PersistentHashMap.fromPairs()", () {
    
  });
  
  new PersistentBiMapTester().testPersistentBiMap();
  
}

class PersistentBiMapTester
    extends Object
    with 
      PersistentAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  final ImmutableBiMap empty = ImmutableBiMap.EMPTY;
  final ImmutableBiMap single = ImmutableBiMap.EMPTY.insert(1, 1);
  final ImmutableBiMap big = ImmutableBiMap.EMPTY.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => ImmutableBiMap.EMPTY;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentBiMapTester();
  
  testPersistentBiMap() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}