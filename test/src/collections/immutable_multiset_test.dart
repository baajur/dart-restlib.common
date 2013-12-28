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
        ..addAllCount = 1000
        ..addCount = 1000
        ..generator = ((final int size) => 
            Persistent.EMPTY_MULTISET.addAll(new List.generate(size, (i) => i)))
        ..elementGenerator = new SequenceElementGenerator()
        ..removeCount = 1000
        ..testSizes = [0,1,1000]
        ..testImmutableMultiset());
  
  group("copyonwrite", () => 
      new ImmutableMultisetTester()
        ..addAllCount = 10
        ..addCount = 10
        ..generator = ((final int size) => 
            (new CopyOnWriteMultisetBuilder()..addAll(new List.generate(size, (i) => i))).build())
        ..elementGenerator = new SequenceElementGenerator()
        ..removeCount = 10
        ..testSizes = [0,1,10]
        ..testImmutableMultiset());
}