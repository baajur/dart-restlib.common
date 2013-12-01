part of restlib.common.collections_test;

persistentDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY,
      PersistentDictionary.EMPTY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY.insert("a", "a").insert("b", "b"),
       PersistentDictionary.EMPTY.insert("b", "b").insert("a", "a"),
       new PersistentDictionary.fromMap({"a" : "a", "b" : "b"}),
       PersistentDictionary.EMPTY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
      ])
  ..executeTestCase();
  

  group("PersistentHashMap.fromMap()", () {
    
  });
  
  group("PersistentHashMap.fromPairs()", () {
    
  });
  
  new PersistentDictionaryTester().testPersistentDictionary();
  
}

class PersistentDictionaryTester
    extends Object
    with 
      PersistentAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  final PersistentDictionary empty = PersistentDictionary.EMPTY;
  final PersistentDictionary single = PersistentDictionary.EMPTY.insert(1, 1);
  final PersistentDictionary big = PersistentDictionary.EMPTY.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => PersistentDictionary.EMPTY;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentDictionaryTester();
  
  testPersistentDictionary() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}