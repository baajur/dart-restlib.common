library restlib.common.objects_test;

import "package:unittest/unittest.dart";

// Use an alias to avoid method collissions with those unittest.dart
import "package:restlib_common/objects.dart" as objects;

part "src/objects/forwarder_test.dart";
part "src/objects/pattern_matching_test.dart";

void objectsTests() {
  group("computeHashCode", () {
    test("with two iterables containing the same values", () {
      final Iterable<String> fst = ["a", "b", "c"];
      final Iterable<String> snd = ["a", "b", "c"];

      expect(objects.computeHashCode(fst), equals(objects.computeHashCode(snd)));
    });

    test("with two iterables containing different values", () {
      final Iterable<String> fst = ["a", "b", "c"];
      final Iterable<String> snd = ["A", "B", "C"];

      expect(objects.computeHashCode(fst) != objects.computeHashCode(snd) , isTrue);
    });
  });

  group("computeIfNull", () {
    test("with non-null object", () {
      final Object fst = new Object();
      final Object snd = new Object();
      expect(objects.computeIfNull(fst, () => snd), equals(fst));
    });

    test("with null object", () {
      final Object snd = new Object();
      expect(objects.computeIfNull(null, () => snd), equals(snd));
    });
  });

  group("computeIfNotNull", () {
    test("with non-null object", () {
      bool result = false;
      final testCase = new Object();
      objects.computeIfNotNull(testCase, (final value) {
        result = true;
        expect(value, equals(testCase));
      });

      expect(result, isTrue);
    });

    test("with null", () {
      bool result = false;
      objects.computeIfNotNull(null, (final value) {
        result = true;
      });

      expect(result, isFalse);
    });
  });

  group("equals()", () {
    test("with eaual objects", () {
      final Object obj = "";
      expect(objects.equals(obj)(obj), isTrue);
    });

    test("with unequal objects", () =>
        expect(objects.equals(new Object())(new Object()), isFalse));
  });

  group("firstNotNull", () {
    test("with non-null first object and null second object", () {
      final Object fst = new Object();
      final Object snd = null;

      expect(objects.firstNotNull(fst, snd), equals(fst));
    });

    test("with null first object and non-null second object", () {
      final Object fst = null;
      final Object snd = new Object();

      expect(objects.firstNotNull(fst, snd), equals(snd));
    });

    test("with non-null first object and non-null second object", () {
      final Object fst = new Object();
      final Object snd = new Object();

      expect(objects.firstNotNull(fst, snd), equals(fst));
    });

    test("with null first object and null second object", () =>
        expect(() => objects.firstNotNull(null, null), throwsArgumentError));
  });

  group("isFalse", () {
    test("with true", () =>
        expect(objects.isFalse(true), isFalse));
    test("with false", () =>
        expect(objects.isFalse(false), isTrue));
  });

  group("isNotNull", () {
    test("with null", () =>
        expect(objects.isNotNull(null), isFalse));
    test("with not null object", () =>
        expect(objects.isNotNull(new Object()), isTrue));
  });

  group("isNull", () {
    test("with null", () =>
        expect(objects.isNull(null), isTrue));
    test("with not null object", () =>
        expect(objects.isNull(new Object()), isFalse));
  });

  group("isTrue", () {
    test("with true", () =>
        expect(objects.isTrue(true), isTrue));
    test("with false", () =>
        expect(objects.isTrue(false), isFalse));
  });

  test("nullToEmpty", () {
    expect(objects.nullToEmpty(null), equals(""));
    expect(objects.nullToEmpty("a"), equals("a"));
  });

  test("objectToString", () {
    String test = "test";
    expect(objects.objectToString(test), equals(test));
  });
}

void objectTestGroup() {
  group("package:object", () {
    group("class:NoSuchMethodForwarder", noSuchMethodForwarderTests);
    group("class:ToStringForwarder", toStringForwarderTests);
    patternMatchingTests();
    objectsTests();
  });
}

void main() {
  objectTestGroup();
}