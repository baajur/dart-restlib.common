part of restlib.common.collections_test;

typedef MutableAssociative MutableAssociativeGenerator(int size);

abstract class MutableAssociativeTester {
  dynamic get generator;
  PairGenerator get pairGenerator;
  
  testMutableAssociative() {
    test("operator [](K,V)", () {
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        
        expect(assoc[next.fst], isEmpty);
        assoc[next.fst]= next.snd;
        expect(assoc[next.fst].first, next.snd);
      }
    });
    
    group("clear()", () {
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        assoc[next.fst]= next.snd;
      }
      expect(assoc.keys.isNotEmpty, isTrue);
      expect(assoc.values.isNotEmpty, isTrue);
      
      assoc.clear();
      
      expect(assoc.keys, isEmpty);
      expect(assoc.values, isEmpty);
    });
    group("insert()", (){
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        
        expect(assoc[next.fst], isEmpty);
        assoc.insert(next.fst, next.snd);
        expect(assoc[next.fst].contains(next.snd), isTrue);
      }     
    });
    group("insertAll()", () {
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      
      Array<Pair> array = new Array.ofSize(size);
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        array[i] = next;
      }
      
      assoc.insertAll(array);
      array.forEach((final Pair pair) =>
          expect(assoc[pair.fst].contains(pair.snd), isTrue));
      
    });
    group("insertPair()", () {
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        
        expect(assoc[next.fst], isEmpty);
        assoc.insertPair(next);
        expect(assoc[next.fst].contains(next.snd), isTrue);
      }     
    });
    group("removeAt", () {
      final int size = 1000;
      final MutableAssociative assoc = generator(size);
      
      pairGenerator.reset();
      for (int i = 0; i < size; i++) {
        assoc.insertPair(pairGenerator.next());
      }
      
      while (assoc.keys.isNotEmpty) {
        final key = assoc.keys.first;
        final value = assoc[key].first;
        
        assoc.removeAt(key);
        
        expect(assoc[key].contains(value), isFalse);
      }
    });
  }
}

abstract class PairGenerator {
  void reset();
  Pair next();
}