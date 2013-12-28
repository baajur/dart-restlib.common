part of restlib.common.collections_test;

immutableSequenceTests() {  
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE, 
                        Persistent.EMPTY_SEQUENCE.add("a").tail,
                        new CopyOnWriteSequenceBuilder().build()])
    ..addEqualityGroup([Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), 
                        Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c"]), 
                        Persistent.EMPTY_SEQUENCE.addAll(["a", "b", "c", "d"]).tail,
                        (new CopyOnWriteSequenceBuilder()
                          ..addAll(["a", "b", "c"]))
                          .build()])
    ..executeTestCase();
    
  group("persistent", () => 
      new ImmutableSequenceTester()
        ..addAllCount = 1000
        ..addCount = 1000
        ..elementGenerator = new SequenceElementGenerator()
        ..generator = ((final int size) => 
              Persistent.EMPTY_SEQUENCE.addAll(new List.generate(size, (i) => i)))
        ..insertAllCount = 1000
        ..insertCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..removeCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableSequence()); 
  
  group("copyonwrite", () => 
      new ImmutableSequenceTester()
        ..addAllCount = 10
        ..addCount = 10
        ..elementGenerator = new SequenceElementGenerator()
        ..generator = ((final int size) => 
              (new CopyOnWriteSequenceBuilder()
                ..addAll(new List.generate(size, (i) => i)))
                .build())
        ..insertAllCount = 10
        ..insertCount = 10
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 10
        ..removeCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableSequence());
}