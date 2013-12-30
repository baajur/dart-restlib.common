import "package:unittest/unittest.dart";
import "package:restlib_common/preconditions.dart";

void preconditionsTests() {
  group("checkArgument", () {
    test("with true", () => 
        expect(checkArgument(true), isNull));
    test("with false", () => 
        expect(() => checkArgument(false), throwsArgumentError));
  });

  group("checkRangeInclusive", () {
    test("with value below range", () => 
        expect(() => checkRangeInclusive(-2, -1, 1), throwsRangeError));
    test("with floor value", () =>
        expect(checkRangeInclusive(-1, -1, 1), isNull));
    test("with value in range", () =>
        expect(checkRangeInclusive(0, -1, 1), isNull));
    test("with ceiling value", () => 
        expect(checkRangeInclusive(1, -1, 1), isNull));
    test("with value above range", () =>
        expect(() => checkRangeInclusive(2, -1, 1), throwsRangeError));
    test("with low == high", () => 
        expect(() => checkRangeInclusive(0, 1, 1), throwsArgumentError));
    test("with low > high", () => 
        expect(() => checkRangeInclusive(0, 2, 1), throwsArgumentError));
  });
  
  group("checkNotNull", () {
    test("with null", () => 
        expect(() => checkNotNull(null), throwsArgumentError));
    test("with non-null object", () {
      final Object testObj = new Object();
      expect(checkNotNull(testObj), equals(testObj));
    });
  });
  
  group("checkState", () {
    test("with true", () => 
        expect(checkState(true), isNull));
    test("with false", () => 
        expect(() => checkState(false), throwsStateError));
  });
}

void preconditionsTestGroup() =>
    group("package:preconditions", preconditionsTests);

void main() {
  preconditionsTestGroup();
}
