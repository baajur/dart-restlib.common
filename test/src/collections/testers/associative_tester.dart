part of restlib.common.collections_test;

abstract class AssociativeTester {
  dynamic get invalidKey;
  Iterable<int> get testSizes;
  
  void _doAssociativeTest(final String testDescription, func(Associative testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Associative of size $size", () => func(generateTestData(size)))));
  
  dynamic generateTestData(int size);  
  
  void testContainsKey(final Associative testData) {
    testData.keys.forEach((final key) => 
        expect(testData.containsKey(key), isTrue));
    expect(testData.containsKey(invalidKey), isFalse);
  }
  
  void testContainValues(final Associative testCase) {
    testCase.values.forEach((final value) =>
        expect(testCase.containsValue(value), isTrue));
    expect(testCase.containsValue(invalidKey), isFalse);
  }
  
  void testOperatorListAccess(final Associative testCase) {
    expect(testCase[invalidKey], isEmpty);
    testCase.keys.forEach((final dynamic key) => 
        expect(testCase[key].isEmpty, isFalse)); 
  }
  
  void testAssociative () {
    checkNotNull(invalidKey);
    checkNotNull(testSizes);
    
    _doAssociativeTest("containsKey()", testContainsKey);
    _doAssociativeTest("containsValue()", testContainValues);
    _doAssociativeTest("operator []", testOperatorListAccess);
  }
}