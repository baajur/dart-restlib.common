part of restlib.common.collections_test;

class MutableBiMapTester 
    extends Object
    with MutableAssociativeTester,
      AssociativeTester,
      BiMapTester,
      IterableTester {
  
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testMutableBiMap() {
    testIterable();
    testAssociative();
    testBiMap();
    testMutableAssociative();
  }
}