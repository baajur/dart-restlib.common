part of objects;

class PatternMatcher<T> {
  final ImmutableSequence<Pattern> _patterns;
  
  PatternMatcher(final Iterable<Pattern> patterns) :
    _patterns = EMPTY_SEQUENCE.addAll(patterns);

  Option<T> call(final obj) =>
      firstWhere(_patterns, (final Pattern<T> p) => 
          p.matches(obj))
        .map((final Pattern<T> p) => 
            p.apply(obj));    
}

Pattern inCaseOf(final Predicate matcher, /*<T>*/ apply(obj)) =>
    new Pattern.inCaseOf(matcher, apply);

Pattern otherwise(apply(obj)) =>
    new Pattern.otherwise(apply);

abstract class Pattern<T> {  
  factory Pattern.inCaseOf(final Predicate matcher, T apply(obj)) =>
      new _PatternImpl<T>(matcher, apply);
  
  factory Pattern.otherwise(T apply(obj)) =>
      new _PatternImpl<T>((_) => true, apply);    
      
  bool matches(obj);
  T apply(e);
}

class _PatternImpl<T> implements Pattern<T> {
  final Predicate _matches;
  final Function _apply;

  _PatternImpl(this._matches, T apply(obj)) :
    this._apply = apply;
  
  bool matches(final obj) =>
      _matches(obj);
  
  T apply(final e) =>
      _apply(e);
}

