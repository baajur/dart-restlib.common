part of restlib.common.collections_test;

immutableSequenceTests() {  
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE, Persistent.EMPTY_SEQUENCE.add("a").tail])
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
    
  
  group("persistent", () => 
      new ImmutableSequenceTester()
        ..elementGenerator = new SequenceElementGenerator()
        ..generator = ((final int size) => 
              Persistent.EMPTY_SEQUENCE.addAll(new List.generate(size, (i) => i)))
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableSequence()); 
  
  group("copyonwrite", () => 
      new ImmutableSequenceTester()
        ..elementGenerator = new SequenceElementGenerator()
        ..generator = ((final int size) => 
              (new CopyOnWriteSequenceBuilder()
                ..addAll(new List.generate(size, (i) => i)))
                .build())
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableSequence());
}