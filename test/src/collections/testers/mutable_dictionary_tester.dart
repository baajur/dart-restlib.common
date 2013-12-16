part of restlib.common.collections_test;

class MutableDictionaryTester 
    extends Object
    with MutableAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testMutableDictionary() {
    testIterable();
    testAssociative();
    testMutableAssociative();
  }
}