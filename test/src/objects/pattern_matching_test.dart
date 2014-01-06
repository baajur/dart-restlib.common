part of restlib.common.objects_test;

void patternMatchingTests() {
  test("patternMatch()", () {
    final objects.PatternMatcher<int> matcher =
        new objects.PatternMatcher<int>(
          [objects.inCaseOf(new objects.IsInstanceOf<String>(), (_) => 1),
           objects.inCaseOf((final obj) => obj == 1, (_) => 2),
           objects.otherwise((_) => 3)
          ]);
    
    expect(matcher("string").value, equals(1));
    expect(matcher(1).value, equals(2));
    expect(matcher(new Object()).value, equals(3));
  });
}