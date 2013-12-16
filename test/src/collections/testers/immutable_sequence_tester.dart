part of restlib.common.collections_test;

class ImmutableSequenceTester
    extends Object
    with 
      ImmutableAssociativeTester,
      ImmutableCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  
  ElementGenerator elementGenerator;
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testImmutableAssociative();
    testPersistentCollection();
  }
}