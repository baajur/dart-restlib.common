part of restlib.common.collections_test;

mutableSequenceTests() {
  group("class:FixedSizeSequence", () {
    new IterableTester()
      ..empty = new FixedSizeSequence(0)
      ..mapFunc = ((_) => 2)
      ..mappedSingleItr = (new FixedSizeSequence(1)..add(2))
      ..other = 3
      ..singleItr = (new FixedSizeSequence(1)..add(1))
      ..singleValue = 1
      ..test();
  });
}



