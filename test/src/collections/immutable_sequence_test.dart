part of restlib.common.collections_test;

immutableSequenceTests() {  
  new EqualsTester()
    ..addEqualityGroup(
        [EMPTY_SEQUENCE, 
         EMPTY_SEQUENCE.add("a").tail])
    ..addEqualityGroup(
        [EMPTY_SEQUENCE.addAll(["a", "b", "c"]), 
         EMPTY_SEQUENCE.addAll(["a", "b", "c"]), 
         EMPTY_SEQUENCE.addAll(["a", "b", "c", "d"]).tail
        ])
    ..executeTestCase();
    
  group("persistent", () => 
      new ImmutableSequenceTester()
        ..addAllCount = 1000
        ..addCount = 1000
        ..elementGenerator = new SequenceElementGenerator()
        ..generator = ((final int size) => 
              EMPTY_SEQUENCE.addAll(new List.generate(size, (i) => i)))
        ..insertAllCount = 1000
        ..insertCount = 1000
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..removeAtCount = 1000
        ..removeCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableSequence()); 
}