part of restlib.common.collections_test;

abstract class MultisetTester {
  Iterable<int> get testSizes;
  
  void _doMultisetTest(String testDescription, func(Multiset testData, int size)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Multiset of size $size", () => func(generateTestData(size), size))));
  
  dynamic generateTestData(int size);  
  
  void testGetElements(final Multiset testData, final int size) =>
      testData.forEach((final dynamic element) =>
          expect(testData.elements.contains(element), isTrue));
  
  void testGetEntries(final Multiset testData, final int size) =>
      expect(testData.entries.length, equals(testData.elements.length));
  
  void testCount(final Multiset testData, final int size) =>
      testData.entries.forEach((final Pair<dynamic,int> pair) =>
          expect(testData.count(pair.fst), equals(pair.snd)));
  
  void testMultiset() {
    checkNotNull(testSizes);
    
    _doMultisetTest("get elements", testGetElements);
    _doMultisetTest("get entries", testGetEntries);
    _doMultisetTest("count()", testCount);
  }
}