part of restlib.common.collections_test;

persistentDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY,
      Persistent.EMPTY_DICTIONARY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [Persistent.EMPTY_DICTIONARY.insert("a", "a").insert("b", "b"),
       Persistent.EMPTY_DICTIONARY.insert("b", "b").insert("a", "a"),
       Persistent.EMPTY_DICTIONARY.insertAllFromMap({"a" : "a", "b" : "b"}),
       Persistent.EMPTY_DICTIONARY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
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
  
  final ImmutableDictionary empty = Persistent.EMPTY_DICTIONARY;
  final ImmutableDictionary single = Persistent.EMPTY_DICTIONARY.insert(1, 1);
  final ImmutableDictionary big = Persistent.EMPTY_DICTIONARY.insertAll(new List.generate(1000, (i) => new Pair(i,i)));
  final int invalidKey = 1001;
  
  final dynamic generator = () => Persistent.EMPTY_DICTIONARY;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  
  PersistentDictionaryTester();
  
  testPersistentDictionary() {
    testIterable();
    testAssociative();
    testPersistentAssociative();
  }
}