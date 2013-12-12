part of restlib.common.collections_test;

persistentBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP,
      Persistent.EMPTY_BIMAP.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [Persistent.EMPTY_BIMAP.insert("a", "a").insert("b", "b"),
       Persistent.EMPTY_BIMAP.insert("b", "b").insert("a", "a"),
       Persistent.EMPTY_DICTIONARY.insertAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_BIMAP.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
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
  
  final ImmutableBiMap empty = Persistent.EMPTY_BIMAP;
  final ImmutableBiMap single = Persistent.EMPTY_BIMAP.insert(1, 1);
  final ImmutableBiMap big = Persistent.EMPTY_BIMAP.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => Persistent.EMPTY_BIMAP;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentBiMapTester();
  
  testPersistentBiMap() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}