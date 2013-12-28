part of restlib.common.collections_test;

abstract class MultimapTester {
  Iterable<int> get testSizes;
  dynamic generateTestData(int size); 
  
  void _doMultimapTest(final String testDescription, func(Multimap testData)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Multimap of size $size", () => func(generateTestData(size)))));
  
  void testGetDictionary(final Multimap multimap);

  void testMultimap() {
    _doMultimapTest("get dictionary", testGetDictionary);
  }
}

abstract class MultisetMultimapTester {
  void testGetDictionary(final MultisetMultimap multimap) {
    multimap.keys.forEach((final key) {
      expect(multimap.dictionary.containsKey(key), isTrue);
      
      multimap[key].forEach((final value) => 
          expect(multimap.dictionary[key].value.count(value), equals(multimap[key].count(value))));
    });
    
    multimap.dictionary.keys.forEach((final key) {
      expect(multimap.containsKey(key), isTrue);
    });
  }
}

abstract class SequenceMultimapTester {
  void testGetDictionary(final SequenceMultimap multimap) {
    multimap.keys.forEach((final key) {
      expect(multimap.dictionary.containsKey(key), isTrue);
      
      expect(equal(multimap[key], multimap.dictionary[key].value), isTrue);
    });
    
    multimap.dictionary.keys.forEach((final key) {
      expect(multimap.containsKey(key), isTrue);
      
      expect(equal(multimap[key], multimap.dictionary[key].value), isTrue);
    });
  }
}

abstract class SetMultimapTester {
  void testGetDictionary(final SetMultimap multimap) {
    multimap.keys.forEach((final key) {
      expect(multimap.dictionary.containsKey(key), isTrue);
        
      multimap[key].forEach((final value) => 
          expect(multimap.dictionary[key].value.contains(value), isTrue));
    });
    
    multimap.dictionary.keys.forEach((final key) {
      expect(multimap.containsKey(key), isTrue);
      
      multimap.dictionary[key].value.forEach((final value) => 
          expect(multimap[key].contains(value), isTrue));
    });
  }
}

