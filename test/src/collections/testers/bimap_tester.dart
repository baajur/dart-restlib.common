part of restlib.common.collections_test;

abstract class BiMapTester {
  Iterable<int> get testSizes;
  
  void _doBiMapTest(final String testDescription, func(BiMap testData, int size)) =>
      group(testDescription, () =>
          testSizes.forEach((final int size) => 
              test("with BiMap of size $size", () => 
                  func(generateTestData(size), size))));  

  dynamic generateTestData(int size);

  void testGetInverse(final BiMap testData, final int size) {
    final BiMap inverse = testData.inverse;
    testData.forEach((final Pair pair) => 
        expect(inverse[pair.snd].value, equals(pair.fst))); 
  }
  
  void testBiMap() {
    checkNotNull(testSizes);
    
    _doBiMapTest("get inverse", testGetInverse);
  }
}

