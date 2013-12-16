part of restlib.common.collections_test;

persistentSetTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SET, Persistent.EMPTY_SET.addAll([]), Persistent.EMPTY_SET.add("a").remove("a")])
    ..addEqualityGroup([Persistent.EMPTY_SET.addAll(["a", "b", "c"]), Persistent.EMPTY_SET.addAll(["a", "b", "c"]), Persistent.EMPTY_SET.addAll(["a", "b", "c", "d"]).remove("d")])
    ..executeTestCase();
  
  new ImmutableSetTester()
    ..elementGenerator = new SequenceElementGenerator()
    ..generator =((final int size) => 
        Persistent.EMPTY_SET.addAll(new List.generate(size, (i) => i)))
    ..testSizes = [0, 1, 1000]
    ..testImmutableSet();
}