part of restlib.common.collections_test;

void immutableMultisetTests() {  
  new EqualsTester()
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET,
       Persistent.EMPTY_MULTISET.add("a").remove("a"),
       (new CopyOnWriteMultisetBuilder()).build()])
  ..addEqualityGroup(
      [Persistent.EMPTY_MULTISET.add("a"),
       Persistent.EMPTY_MULTISET.add("a"),
       (new CopyOnWriteMultisetBuilder()..add("a")).build()])     
  ..executeTestCase();
  
  group("persistent", () => 
      new ImmutableMultisetTester()
        ..generator = ((final int size) => 
            Persistent.EMPTY_MULTISET.addAll(new List.generate(size, (i) => i)))
        ..elementGenerator = new SequenceElementGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableMultiset());
  
  group("copyonwrite", () => 
      new ImmutableMultisetTester()
        ..generator = ((final int size) => 
            (new CopyOnWriteMultisetBuilder()..addAll(new List.generate(size, (i) => i))).build())
        ..elementGenerator = new SequenceElementGenerator()
        ..testSizes = [0,1,1000]
        ..testImmutableMultiset());
}