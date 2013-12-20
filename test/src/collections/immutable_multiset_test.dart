part of restlib.common.collections_test;

void immutableMultisetTests() {  
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET,
       Persistent.EMPTY_MULTISET.add("a").remove("a")])
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET.add("a"),
       Persistent.EMPTY_MULTISET.add("a")])     
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableMultisetTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_MULTISET.addAll(new List.generate(size, (i) => i)))
        ..elementGenerator = new SequenceElementGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableMultiset());
}