part of restlib.common.objects;

typedef Predicate(dynamic object);

class PatternMatcher<T> implements Function {
  final ImmutableSequence<Pattern> _patterns;
  
  PatternMatcher(final Iterable<Pattern> patterns) :
    _patterns = Persistent.EMPTY_SEQUENCE.addAll(patterns);

  Option<T> call(final obj) =>
      firstWhere(_patterns, (final Pattern p) => 
          p.matches(obj))
        .map((final Pattern p) => 
            p.apply(obj));    
}

Pattern inCaseOf(final Predicate matcher, apply(obj)) =>
    new _PatternImpl(matcher, apply);

Pattern otherwise(apply(obj)) =>
    new _PatternImpl((_) => true, apply);

abstract class Pattern {
  bool matches(obj);
  dynamic apply(e);
}



      

class _PatternImpl implements Pattern {
  final Predicate _matches;
  final Function _apply;

  _PatternImpl(this._matches, this._apply);
  
  bool matches(final obj) =>
      _matches(obj);
  
  dynamic apply(final e) =>
      _apply(e);
}

