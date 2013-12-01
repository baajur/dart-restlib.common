part of restlib.common.collections_test;

persistentSequenceTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentSequence.EMPTY, new PersistentSequence.from([]), PersistentSequence.EMPTY.add("a").tail])
    ..addEqualityGroup([new PersistentSequence.from(["a", "b", "c"]), new PersistentSequence.from(["a", "b", "c"]), new PersistentSequence.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("PersistentSequence.from()", () {
    test("with empty Iterable", () =>
        expect(identical(PersistentSequence.EMPTY, new PersistentSequence.from([])), isTrue));
    test("with PersistentSequence", () {
      final PersistentSequence<String> test = PersistentSequence.EMPTY.add("a").add("b");
      expect(identical(test, new PersistentSequence.from(test)), isTrue);
    });
  });
  
  new PersistentSequenceTester(() => PersistentSequence.EMPTY)
    ..testPersistentSequence();  
}

class PersistentSequenceTester
    extends Object
    with 
      PersistentAssociativeTester,
      PersistentCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  
  final PersistentSequence empty;
  final PersistentSequence single;
  final PersistentSequence big;
  final int invalidKey;
  
  final dynamic generator;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  
  PersistentSequenceTester(generator) :
    empty = generator(),
    single = generator().add(1),
    big = (generator().addAll(new List.generate(1000, (i) => i))),
    invalidKey = 1001,
    generator = generator;
  
  testPersistentSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testPersistentAssociative();
    testPersistentCollection();
  }
}