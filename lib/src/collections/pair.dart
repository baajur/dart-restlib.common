part of collections;

abstract class Pair<T1, T2> {
  factory Pair(final T1 fst, final T2 snd) =>
      new _Pair(checkNotNull(fst), checkNotNull(snd));
  
  T1 get fst;
  T2 get snd;
}

class _Pair<T1, T2> implements Pair<T1, T2> {
  final T1 fst;
  final T2 snd;
    
  _Pair(this.fst, this.snd);
    
  int get hashCode => 
      computeHashCode([fst, snd]);
    
  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Pair) {
      return this.fst == other.fst &&
          this.snd == other.snd;
    } else {
      return false;
    }
  }
    
  String toString() => 
      "Pair($fst, $snd)";
}
