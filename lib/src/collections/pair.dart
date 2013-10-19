part of restlib.common.collections;

class Pair<T1, T2> {
  final T1 fst;
  final T2 snd;
  
  const Pair(this.fst, this.snd);
  
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
