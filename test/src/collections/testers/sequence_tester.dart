part of restlib.common.collections_test;

abstract class SequenceTester {
  Sequence get empty;
  Sequence get single;
  Sequence get big;

  testSequence() {
    group("get reversed", () {
      test("with empty", () =>
          expect(empty.reversed, isEmpty));
      test("with single", () =>
          expect(single.reversed, equals(single)));
      test("with big", () {
        Sequence bigReversed = big.reversed;
        for (int i = 0; i < big.length; i++) {
          expect(bigReversed[i], big[big.length - (1 + i)]);
        }
      });
    });
    
    group("operator []", () {
      test("with empty", () =>
          expect(empty[1], equals(Option.NONE)));
      test("with single", () {
        expect(single[2], equals(Option.NONE));
        expect(single[single.keys.first].first, single.values.first);
      });
      test("with big", () {
        int index = 0;
        big.forEach((e) {
          expect(big[index].first, equals(e));
          index++;
        });
        expect(big[big.length], equals(Option.NONE));
      });
    });
    
    test("indexOf()", (){
      for (int i = 0; i < big.length; i++){
        expect(big.indexOf(big.elementAt(i)), equals(i));
        expect(big.indexOf(big.elementAt(i), i), equals(i));
      }
    });
    
    group("subSequence()", () {
      test("with empty", () =>
          expect(empty.subSequence(0, 0), isEmpty));
      test("with single", () { 
        expect(single.subSequence(0, 1), equals(single));
        expect(single.subSequence(0, 0), isEmpty);
      });
      test("with big", () {
        expect(big.subSequence(0, 0), isEmpty);
        
        final Sequence subSequence = big.subSequence(1, big.length -1);
        for (int i = 1; i < big.length - 1; i++) {
          expect(big[i], equals(subSequence[i -1]));
        }
      });
    });
  }
}