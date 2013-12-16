part of restlib.common.collections_test;

class MutableSequenceTester
    extends Object
    with MutableAssociativeTester, 
      MutableCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  final int invalidKey;
  
  final dynamic generator;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  
  Iterable<int> get testSizes =>
      [0,1,1000];
  
  Iterable generateTestData(int size) =>
      generator(size)..addAll(new List.generate(size, (i) => i));
  
  MutableSequenceTester(generator) :
    invalidKey = 1001,
    generator = generator;
  
  testMutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testMutableAssociative();
    testMutableCollection();
  }
}
