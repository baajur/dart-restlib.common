library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/testers/associative_tester.dart";
part "src/collections/testers/iterable_tester.dart";
part "src/collections/testers/mutable_associative_tester.dart";
part "src/collections/testers/mutable_collection_tester.dart";
part "src/collections/testers/persistent_associative_tester.dart";
part "src/collections/testers/persistent_collection_tester.dart";
part "src/collections/testers/sequence_tester.dart";
part "src/collections/testers/stack_tester.dart";

part "src/collections/either_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/mutable_sequence_test.dart";
part "src/collections/option_test.dart";
part "src/collections/pair_test.dart";
part "src/collections/persistent_bimap_test.dart";
part "src/collections/persistent_dictionary_test.dart";
part "src/collections/persistent_sequence_test.dart";
part "src/collections/persistent_set_test.dart";
part "src/collections/persistent_stack_test.dart";

collectionsTestGroup() {
  group("package:collections", () {
    iterablesTests();
    
    group("class:Either", eitherTests);
    group("class:Option", optionTests);
    group("class:Pair", pairTests);
    
    group("class:FixedSizeSequence", () {
      new MutableSequenceTester((final int size) => new MutableFixedSizeSequence(size))
        ..testMutableSequence();
    });
  
    group("class:GrowableSequence", () {
      new MutableSequenceTester((final int size) => new GrowableSequence())
        ..testMutableSequence();  
    });
    
    group("class:PersistenthBiMap", persistentBiMapTests);
    group("class:PersistentDictionary", persistentDictionaryTests);
    group("class:PersistentSequence", persistentSequenceTests);
    group("class:PersistentSet", persistentSetTests);
    group("class:PersistentStack", persistentStackTests);
  });
}

main() {  
  collectionsTestGroup();
}