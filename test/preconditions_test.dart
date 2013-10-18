import "package:unittest/unittest.dart";
import "package:restlib_common/preconditions.dart";

preconditionsTests() {
  test("checkArgument", () {
    expect(checkArgument(true), isNull);
    expect(() => checkArgument(false), throwsArgumentError);
  });
  
  test("checkRangeInclusive", () {
    expect(() => checkRangeInclusive(-2, -1, 1), throwsRangeError);
    
    expect(checkRangeInclusive(-1, -1, 1), isNull);
    expect(checkRangeInclusive(0, -1, 1), isNull);
    expect(checkRangeInclusive(1, -1, 1), isNull);
    
    expect(() => checkRangeInclusive(2, -1, 1), throwsRangeError);
    
    expect(() => checkRangeInclusive(0, 1, 1), throwsArgumentError);
    expect(() => checkRangeInclusive(0, 2, 1), throwsArgumentError);    
  });
  
  test("checkNotNull", () {
    expect(() => checkNotNull(null), throwsArgumentError);
    
    final Object testObj = new Object();
    expect(checkNotNull(testObj), equals(testObj));
  });
  
  test("checkState", () {
    expect(checkState(true), isNull);
    expect(() => checkState(false), throwsStateError);
  });
}

preconditionsTestGroup() =>
    group("preconditions", preconditionsTests);

main() {
  preconditionsTestGroup();
}
