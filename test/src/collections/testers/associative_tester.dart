part of restlib.common.collections_test;

abstract class AssociativeTester {
  Iterable<int> get testSizes;
  dynamic generateTestData(int size);  
  dynamic get invalidKey;
  
  void _doAssociativeTest(final String testDescription, func(Associative testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Associative of size $size", () => func(generateTestData(size)))));
  
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
    _doAssociativeTest("containsKey()", testContainsKey);
    _doAssociativeTest("containsValue()", testContainValues);
    _doAssociativeTest("operator []", testOperatorListAccess);
  }
}