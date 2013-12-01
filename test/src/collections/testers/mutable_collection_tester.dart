part of restlib.common.collections_test;

typedef MutableCollection MutableCollectionGenerator(int size);

abstract class MutableCollectionTester {
  dynamic get generator;
  ElementGenerator get elementGenerator;
  
  testMutableCollection() {
    test("add()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        collection.add(next);
        expect(collection.contains(next), isTrue);
        expect(collection.length, equals(i + 1));
      }
    });
    test("addAll()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      Array<Pair> array = new Array.ofSize(size);
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        array[i] = next;
      }
      
      collection.addAll(array);
      array.forEach((final element) =>
          expect(collection.contains(element), isTrue));
      
    });
    test("clear()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        collection.add(next);
      }
      
      collection.clear();
      expect(collection, isEmpty);
      expect(collection.length, equals(0));
    });
    test("remove()", () {
      final int size = 10;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      Array<Pair> array = new Array.ofSize(size);
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        array[i] = next;
      }
      
      collection.addAll(array);
      array.forEach((final element) {
        expect(collection.contains(element), isTrue);
        final Option e = collection.remove(element);
        expect(collection.contains(element), isFalse);
        expect(e.first, equals(element));
      });
    });
  }
}

abstract class ElementGenerator {
  void reset();
  dynamic next();
}