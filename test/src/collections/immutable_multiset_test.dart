part of restlib.common.collections_test;

void immutableMultisetTests() {  
  new EqualsTester()
  ..addEqualityGroup(
      [EMPTY_MULTISET,
       EMPTY_MULTISET.add("a").remove("a")
      ])
  ..addEqualityGroup(
      [EMPTY_MULTISET.add("a"),
       EMPTY_MULTISET.add("a"),
      ])     
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableMultisetTester()
        ..addAllCount = 1000
        ..addCount = 1000
        ..generator = ((final int size) => 
            EMPTY_MULTISET.addAll(new List.generate(size, (i) => i)))
        ..elementGenerator = new SequenceElementGenerator()
        ..removeCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableMultiset());
}