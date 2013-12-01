part of restlib.common.collections_test;

abstract class AssociativeTester {
  dynamic get empty;
  dynamic get single;
  dynamic get big;
  
  dynamic get invalidKey;
  
  testAssociative () {
    group("containsKey()", () {
      testContainsKey(final Associative testCase) {
        testCase.keys.forEach((key) =>
            expect(testCase.containsKey(key), isTrue));
        expect(testCase.containsKey(invalidKey), isFalse);
      }
      
      test("with empty", () =>
          testContainsKey(empty));
      test("with single", () =>
          testContainsKey(single));
      test("with big", () =>
          testContainsKey(big));
    });
    
    group("containsValue()", () {
      testContainsValue(final Associative testCase) {
        testCase.values.forEach((value) =>
            expect(testCase.containsValue(value), isTrue));
        expect(testCase.containsValue(invalidKey), isFalse);
      }
      
      test("with empty", () =>
          testContainsValue(empty));
      test("with single", () =>
          testContainsValue(single));
      test("with big", () =>
          testContainsValue(big));
    });
   
    group("operator []", () {
      test("with empty", () =>
          expect(empty[invalidKey], isEmpty));
      test("with single", () {
        expect(single[invalidKey], isEmpty);
        expect(single[single.keys.first].first, equals(single.values.first));
      });
      test("with big", () =>
          expect(big[invalidKey], isEmpty));
    });
  }
}