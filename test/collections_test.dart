library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/testers/iterable_tester.dart";

part "src/collections/either_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/mutable_sequence_test.dart";
part "src/collections/option_test.dart";
part "src/collections/pair_test.dart";
part "src/collections/persistent_bimap_test.dart";
part "src/collections/persistent_dictionary_test.dart";
part "src/collections/persistent_sequence_test.dart";
part "src/collections/persistent_stack_test.dart";

collectionsTestGroup() {
  group("package:collections", () {
    iterablesTests();
    
    group("class:Either", eitherTests);
    group("class:Option", optionTests);
    group("class:Pair", pairTests);
    
    mutableSequenceTests();
    
    // group("class:PersistentHashBiMap", persistentHashBiMapTests);
    group("class:PersistentDictionary", persistentDictionaryTests);
    group("class:PersistentSequence", persistentSequenceTests);
    group("class:PersistentStack", persistentStackTests);
  });
}

main() {
  collectionsTestGroup();
}