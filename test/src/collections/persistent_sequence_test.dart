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
      PersistentAssociativeTester,
      PersistentCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  
  final ImmutableSequence empty;
  final ImmutableSequence single;
  final ImmutableSequence big;
  final int invalidKey;
  
  final dynamic generator;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  
  ImmutableSequenceTester(generator) :
    empty = generator(),
    single = generator().add(1),
    big = (generator().addAll(new List.generate(1000, (i) => i))),
    invalidKey = 1001,
    generator = generator;
  
  testImmutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testPersistentAssociative();
    testPersistentCollection();
  }
}