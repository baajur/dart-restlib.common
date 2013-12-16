part of restlib.common.collections_test;

abstract class AssociativeTester {
  Iterable<int> get testSizes;
  dynamic generateTestData(int size);  
  dynamic get invalidKey;
  
  void _doAssociativeTest(String testDescription, func(Associative testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Associative of size $size", () => func(generateTestData(size)))));
  
  void testContainsKey() =>
      _doAssociativeTest("containsKey()", (final Associative testData) {
        testData.keys.forEach((key) =>
            expect(testData.containsKey(key), isTrue));
        expect(testData.containsKey(invalidKey), isFalse);
      });
  
  void testContainValues() =>
      _doAssociativeTest("containsValue()" ,(final Associative testCase) {
        testCase.values.forEach((value) =>
            expect(testCase.containsValue(value), isTrue));
        expect(testCase.containsValue(invalidKey), isFalse);
      });
  
  void testOperatorListAccess() => 
      _doAssociativeTest("operator []", (final Associative testCase) {
        expect(testCase[invalidKey], isEmpty);
        testCase.keys.forEach((final dynamic key) => 
            expect(testCase[key].isEmpty, isFalse)); 
      });
  
  void testAssociative () {
    testContainsKey();
    testContainValues();
    testOperatorListAccess();
  }
}