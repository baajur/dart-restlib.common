part of restlib.common.collections_test;

persistentDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [ImmutableDictionary.EMPTY,
      ImmutableDictionary.EMPTY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [ImmutableDictionary.EMPTY.insert("a", "a").insert("b", "b"),
       ImmutableDictionary.EMPTY.insert("b", "b").insert("a", "a"),
       new ImmutableDictionary.fromMap({"a" : "a", "b" : "b"}),
       ImmutableDictionary.EMPTY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
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
  
  final ImmutableDictionary empty = ImmutableDictionary.EMPTY;
  final ImmutableDictionary single = ImmutableDictionary.EMPTY.insert(1, 1);
  final ImmutableDictionary big = ImmutableDictionary.EMPTY.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => ImmutableDictionary.EMPTY;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentDictionaryTester();
  
  testPersistentDictionary() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}