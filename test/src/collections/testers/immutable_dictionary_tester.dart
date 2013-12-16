part of restlib.common.collections_test;

class ImmutableDictionaryTester 
    extends Object
    with ImmutableAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableDictionary() {
    testIterable();
    testAssociative();
    testImmutableAssociative();
  }
}