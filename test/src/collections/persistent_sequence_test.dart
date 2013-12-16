part of restlib.common.collections_test;

persistentSequenceTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE, Persistent.EMPTY_SEQUENCE.add("a").tail])
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  new ImmutableSequenceTester(() => Persistent.EMPTY_SEQUENCE)
    ..testImmutableSequence();  
}

class ImmutableSequenceTester
    extends Object
    with 
      ImmutableAssociativeTester,
      ImmutableCollectionTester,
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
      Persistent.EMPTY_SEQUENCE.addAll(new List.generate(size, (i) => i));
  
  ImmutableSequenceTester(generator) :
    invalidKey = 1001,
    generator = generator;
  
  testImmutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testImmutableAssociative();
    testPersistentCollection();
  }
}