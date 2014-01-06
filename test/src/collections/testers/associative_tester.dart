part of restlib.common.collections_test;

abstract class AssociativeTester {
  dynamic get invalidKey;
  Iterable<int> get testSizes;
  
  void _doAssociativeTest(final String testDescription, func(Associative testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Associative of size $size", () => 
                  func(generateTestData(size)))));
  
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
  
  void testMapValues(final Associative testCase) {
    final Object mappedObject = new Object();
    final Associative mapped = testCase.mapValues((value) => mappedObject);
    
    // Verify get values
    mapped.values.forEach((final value) =>
        expect(value, equals(mappedObject)));
    
    // Verify get keys
    expect(Persistent.EMPTY_SET.addAll(testCase.keys), equals(Persistent.EMPTY_SET.addAll(mapped.keys)));
    
    // Verify operator[]
    testCase.keys.forEach((final key) => 
        mapped[key].forEach((final value) =>
            expect(value, equals(mappedObject)))); 
    
    // Verify containsKey()
    testCase.keys.forEach((final key) =>
        expect(mapped.containsKey(key), isTrue));
    expect(mapped.containsKey(invalidKey), isFalse);
    
    // Verify containsValue()
    testCase.values.forEach((final value) =>
        expect(mapped.containsValue(value), isFalse));
    if (testCase.values.length > 0) {
      expect(mapped.containsValue(mappedObject), isTrue);
    }
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
    _doAssociativeTest("mapValues()", testMapValues);
    _doAssociativeTest("operator []", testOperatorListAccess);
  }
}