part of restlib.common.collections_test;

abstract class SequenceTester {
  Iterable<int> get testSizes;
  dynamic generateTestData(int size); 
  
  void _doSequenceTest(String testDescription, func(Sequence testData, int size)) =>
      group(testDescription, () =>
          testSizes.forEach((final int size) => 
              test("with Sequence of size $size", () => func(generateTestData(size), size))));   
  
  void testGetReversed() =>
      _doSequenceTest("get reversed", (final Sequence testData, final int size) {
        final Sequence reversed = testData.reversed;
        for (int i = 0; i < testData.length; i++) {
          expect(reversed[i], testData[testData.length - (1 + i)]);
        }
      
        if (testData.isEmpty) {
          expect(reversed, isEmpty);
        }
      });

  void testOperatorListAccess() =>
      _doSequenceTest("operator []", (final Sequence testData, final int size) {
        expect(testData[size], equals(Option.NONE));
      
        testData.keys.forEach((final key) =>
            expect(testData[key].value, equals(testData.elementAt(key))));
      
        int index = 0;
        testData.forEach((final value) {
          expect(testData[index].first, equals(value));
          index++;
        });
      });
  
  void testIndexOf() =>
      _doSequenceTest("operator []", (final Sequence testData, final int size) {
        for (int i = 0; i < size; i++){
          expect(testData.indexOf(testData.elementAt(i)), equals(i));
          expect(testData.indexOf(testData.elementAt(i), i), equals(i));
        }
      });
  
  void testSubSequence() =>
      _doSequenceTest("subSequence()", (final Sequence testData, final int size) {
        expect(testData.subSequence(0, 0), isEmpty);
        expect(testData.subSequence(0, size), equals(testData));
        
        final Sequence subSequence = testData.subSequence(1, size -1);
        for (int i = 1; i < size - 1; i++) {
          expect(testData[i], equals(subSequence[i -1]));
        }
      });
  
  void testSequence() {
    testGetReversed();
    testOperatorListAccess();
    testIndexOf();
    testSubSequence();
  }
}