part of restlib.common.collections_test;

class MutableSequenceTester
    extends Object
    with MutableAssociativeTester, 
      MutableCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  
  ElementGenerator elementGenerator;
  dynamic generator;
  int invalidKey;
  PairGenerator pairGenerator;

  Iterable<int> testSizes;
  
  Iterable generateTestData(int size) =>
      generator(size)..addAll(new List.generate(size, (i) => i));
  
  testMutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testMutableAssociative();
    testMutableCollection();
  }
}
