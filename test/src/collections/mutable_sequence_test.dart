part of restlib.common.collections_test;

class MutableSequenceTester
    extends Object
    with MutableAssociativeTester, 
      MutableCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  final int invalidKey;
  
  final dynamic generator;
  final PairGenerator pairGenerator = new SequencePairGenerator();
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  
  Iterable<int> get testSizes =>
      [0,1,1000];
  
  Iterable generateTestData(int size) =>
      generator(size)..addAll(new List.generate(size, (i) => i));
  
  MutableSequenceTester(generator) :
    invalidKey = 1001,
    generator = generator;
  
  testMutableSequence() {
    testIterable();
    testAssociative();
    testSequence();
    testMutableAssociative();
    testMutableCollection();
  }
}

class SequenceElementGenerator implements ElementGenerator {
int _index = 0;
  
  void reset() {
    _index = 0;
  }
  
  int next() {
    final int retval = _index;
    _index++;
    return retval;
  }
}

class SequencePairGenerator implements PairGenerator {
  int _index = 0;
  
  void reset() {
    _index = 0;
  }
  
  Pair next() {
    final Pair retval = new Pair(_index, _index);
    _index++;
    return retval;
  }
}
      
