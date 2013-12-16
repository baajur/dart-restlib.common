part of restlib.common.collections_test;

immutableSetTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SET, 
                        Persistent.EMPTY_SET.addAll([]), 
                        Persistent.EMPTY_SET.add("a").remove("a"),
                        new CopyOnWriteSetBuilder().build()])
    ..addEqualityGroup([Persistent.EMPTY_SET.addAll(["a", "b", "c"]), 
                        Persistent.EMPTY_SET.addAll(["a", "b", "c"]), 
                        Persistent.EMPTY_SET.addAll(["a", "b", "c", "d"]).remove("d"),
                        (new CopyOnWriteSetBuilder()
                          ..addAll(["a", "b", "c"]))
                          .build()])
    ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableSetTester()
        ..elementGenerator = new SequenceElementGenerator()
        ..generator =((final int size) => 
            Persistent.EMPTY_SET.addAll(new List.generate(size, (i) => i)))
        ..testSizes = [0, 1, 1000]
        ..testImmutableSet());
  
  group("copyonwrite", () =>
      new ImmutableSetTester()
        ..elementGenerator = new SequenceElementGenerator()
        ..generator =((final int size) => 
            (new CopyOnWriteSetBuilder()
              ..addAll(new List.generate(size, (i) => i)))
              .build())
        ..testSizes = [0, 1, 1000]
        ..testImmutableSet());  
}