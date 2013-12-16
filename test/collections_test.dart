library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/testers/associative_tester.dart";
part "src/collections/testers/generators.dart";
part "src/collections/testers/immutable_associative_tester.dart";
part "src/collections/testers/immutable_collection_tester.dart";
part "src/collections/testers/immutable_dictionary_tester.dart";
part "src/collections/testers/immutable_sequence_tester.dart";
part "src/collections/testers/immutable_set_tester.dart";
part "src/collections/testers/immutable_stack_tester.dart";
part "src/collections/testers/iterable_tester.dart";
part "src/collections/testers/mutable_associative_tester.dart";
part "src/collections/testers/mutable_collection_tester.dart";
part "src/collections/testers/sequence_tester.dart";
part "src/collections/testers/stack_tester.dart";

part "src/collections/array_test.dart";
part "src/collections/either_test.dart";
part "src/collections/immutable_bimap_test.dart";
part "src/collections/immutable_dictionary_test.dart";
part "src/collections/immutable_sequence_test.dart";
part "src/collections/immutable_set_test.dart";
part "src/collections/immutable_stack_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/mutable_sequence_test.dart";
part "src/collections/option_array_test.dart";
part "src/collections/option_test.dart";
part "src/collections/pair_test.dart";

collectionsTestGroup() {
  group("package:collections", () {
    iterablesTests();
    
    group("class:Array", () =>
        new ArrayTester().testArray());
    group("class:Either", eitherTests);
    group("class:Option", optionTests);
    group("class:OptionArray", () => new OptionArrayTester().testObjectArray());
    group("class:Pair", pairTests);
    
    group("class:FixedSizeSequence", () {
      new MutableSequenceTester((final int size) => new MutableFixedSizeSequence(size))
        ..testMutableSequence();
    });
  
    group("class:GrowableSequence", () {
      new MutableSequenceTester((final int size) => new GrowableSequence())
        ..testMutableSequence();  
    });
    
    group("class:ImmutableBiMap", immutableBiMapTests);
    group("class:ImmutableDictionary", immutableDictionaryTests);
    group("class:ImmutableSequence", immutableSequenceTests);
    group("class:ImmutableSet", immutableSetTests);
    group("class:ImmutableStack", immutableStackTests);
  });
}

main() {  
  collectionsTestGroup();
}