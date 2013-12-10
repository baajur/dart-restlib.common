part of restlib.common.collections_test;

persistentSequenceTests() {
  new EqualsTester()
    ..addEqualityGroup([ImmutableSequence.EMPTY, new ImmutableSequence.from([]), ImmutableSequence.EMPTY.add("a").tail])
    ..addEqualityGroup([new ImmutableSequence.from(["a", "b", "c"]), new ImmutableSequence.from(["a", "b", "c"]), new ImmutableSequence.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("ImmutableSequence.from()", () {
    test("with empty Iterable", () =>
        expect(identical(ImmutableSequence.EMPTY, new ImmutableSequence.from([])), isTrue));
    test("with ImmutableSequence", () {
      final ImmutableSequence<String> test = ImmutableSequence.EMPTY.add("a").add("b");
      expect(identical(test, new ImmutableSequence.from(test)), isTrue);
    });
  });
  
  new ImmutableSequenceTester(() => ImmutableSequence.EMPTY)
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