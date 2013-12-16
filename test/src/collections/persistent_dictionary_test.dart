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
  
  new ImmutableDictionaryTester()
    ..generator = ((final int size) => 
        Persistent.EMPTY_DICTIONARY.insertAll(new List.generate(size, (i) => new Pair(i,i))))
    ..invalidKey = 1001
    ..pairGenerator = new SequencePairGenerator()
    ..testSizes = [0,1,1000]
    ..testImmutableDictionary();
  
}