part of objects;

class _Curry implements Function {
  final Function function;
  final Iterable positionalParameters;
  final Map<Symbol, dynamic> namedArguments;

  _Curry(this.function, this.positionalParameters, this.namedArguments);

  call() =>
      apply(positionalParameters, namedArguments);

  apply(final Iterable positionalParameters, final Map<Symbol, dynamic> namedArguments) =>
      Function.apply(function, positionalParameters, namedArguments);

  noSuchMethod(final Invocation invocation) =>
      (invocation.memberName == #call) ?
          Function.apply(function,
              []..addAll(positionalParameters)..addAll(invocation.positionalArguments),
              {}..addAll(namedArguments)..addAll(invocation.namedArguments)) :
            super.noSuchMethod(invocation);
}