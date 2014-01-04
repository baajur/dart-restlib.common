part of restlib.common.collections_test;

abstract class DictionaryTester {
  dynamic get invalidKey;
  Iterable<int> get testSizes;
  
  void _doDictionaryTest(final String testDescription, func(Associative testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Dictionary of size $size", () => 
                  func(generateTestData(size)))));
  
  dynamic generateTestData(int size);  
  
  void testAsMap(final Dictionary dictionary) {
    final Map map = dictionary.asMap();
    expect(map.isEmpty, equals(dictionary.isEmpty));
    expect(map.isNotEmpty, equals(dictionary.isNotEmpty));
    map.keys.forEach((final key) {
      expect(dictionary.containsKey(key), isTrue);
      expect(map[key], equals(dictionary[key].value));
    });
    
    expect(map.length, equals(dictionary.length));
    map.values.forEach((final value) => 
        expect(dictionary.containsValue(value), isTrue));
    expect(() => map.addAll({}), throwsUnsupportedError);
    expect(() => map.clear(), throwsUnsupportedError);
    
    dictionary.keys.forEach((final key) =>
        expect(map.containsKey(key), isTrue));
    
    dictionary.values.forEach((final value) => 
        expect(map.containsValue(value), isTrue));

    expect(() => map.putIfAbsent("",() => ""), throwsUnsupportedError);
    expect(() => map.remove(""), throwsUnsupportedError);
  }
  
  void testDictionary() {
    checkNotNull(invalidKey);
    checkNotNull(testSizes);
    
    _doDictionaryTest("asMap()", testAsMap);
  }
}