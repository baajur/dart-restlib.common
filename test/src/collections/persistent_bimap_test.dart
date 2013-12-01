part of restlib.common.collections_test;

persistentBiMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentBiMap.EMPTY,
      PersistentBiMap.EMPTY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [PersistentBiMap.EMPTY.insert("a", "a").insert("b", "b"),
       PersistentBiMap.EMPTY.insert("b", "b").insert("a", "a"),
       new PersistentBiMap.fromMap({"a" : "a", "b" : "b"}),
       PersistentBiMap.EMPTY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
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
  
  final PersistentBiMap empty = PersistentBiMap.EMPTY;
  final PersistentBiMap single = PersistentBiMap.EMPTY.insert(1, 1);
  final PersistentBiMap big = PersistentBiMap.EMPTY.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => PersistentBiMap.EMPTY;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentBiMapTester();
  
  testPersistentBiMap() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}