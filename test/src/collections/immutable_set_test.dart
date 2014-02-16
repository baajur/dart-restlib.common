part of restlib.common.collections_test;

immutableSetTests() {
  new EqualsTester()
    ..addEqualityGroup(
        [EMPTY_SET, 
         EMPTY_SET.addAll([]), 
         EMPTY_SET.add("a").remove("a")])
    ..addEqualityGroup(
        [EMPTY_SET.addAll(["a", "b", "c"]), 
         EMPTY_SET.addAll(["a", "b", "c"]), 
         EMPTY_SET.addAll(["a", "b", "c", "d"]).remove("d")
        ])
    ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableSetTester()
        ..addAllCount = 1000
        ..addCount = 1000
        ..elementGenerator = new SequenceElementGenerator()
        ..generator =((final int size) => 
            EMPTY_SET.addAll(new List.generate(size, (i) => i)))
        ..removeCount = 1000
        ..testSizes = [0, 1, 1000]
        ..testImmutableSet());
}