part of restlib.common.collections_test;

abstract class PairGenerator {
  void reset();
  Pair next();
}

abstract class ElementGenerator {
  void reset();
  dynamic next();
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
      
