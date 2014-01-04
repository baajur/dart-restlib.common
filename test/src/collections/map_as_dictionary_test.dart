part of restlib.common.collections_test;

class _MapAsDictionaryTester 
    extends Object
    with AssociativeTester,
      DictionaryTester,
      IterableTester {
  
  dynamic generator;
  dynamic invalidKey;
  Iterable<int> testSizes;
  
  dynamic generateTestData(int size) =>
      generator(size);
  
  void testMapAsDictionary() {
    checkNotNull(generator);
    
    testAssociative();
    testDictionary();
    testIterable();
  }
}