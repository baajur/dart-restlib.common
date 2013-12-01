part of restlib.common.collections_test;

abstract class PersistentAssociativeTester {
  dynamic get generator;
  PairGenerator get pairGenerator;
  
  testPersistentAssociative() { 
    group("insert()", (){
      final int size = 1000;
      PersistentAssociative assoc = generator();
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        
        expect(assoc[next.fst], isEmpty);
        assoc = assoc.insert(next.fst, next.snd);
        expect(assoc[next.fst].contains(next.snd), isTrue);
      }     
    });
    group("insertAll()", () {
      final int size = 1000;
      PersistentAssociative assoc = generator();
      
      pairGenerator.reset();
      
      Array<Pair> array = new Array.ofSize(size);
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        array[i] = next;
      }
      
      assoc = assoc.insertAll(array);
      array.forEach((final Pair pair) =>
          expect(assoc[pair.fst].contains(pair.snd), isTrue));
      
    });
    group("insertPair()", () {
      final int size = 1000;
      PersistentAssociative assoc = generator();
      
      pairGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final Pair next = pairGenerator.next();
        
        expect(assoc[next.fst], isEmpty);
        assoc = assoc.insertPair(next);
        expect(assoc[next.fst].contains(next.snd), isTrue);
      }     
    });
    test("removeAt", () {
      final int size = 1000;
      PersistentAssociative assoc = generator();
      
      pairGenerator.reset();
      for (int i = 0; i < size; i++) {
        assoc = assoc.insertPair(pairGenerator.next());
      }
      
      while (assoc.keys.isNotEmpty) {
        final key = assoc.keys.first;
        final value = assoc[key].first;
        
        assoc = assoc.removeAt(key);
        
        expect(assoc[key].contains(value), isFalse);
      }
    });
  }
}