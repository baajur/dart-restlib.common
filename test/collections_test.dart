library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/either_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/option_test.dart";
part "src/collections/pair_test.dart";
part "src/collections/persistent_hash_bimap_test.dart";
part "src/collections/persistent_hash_map_test.dart";
part "src/collections/persistent_list_test.dart";

collectionsTestGroup() {
  group("package:collections", () {
    iterablesTests();
    
    group("class:Either", eitherTests);
    group("class:Option", optionTests);
    group("class:Pair", pairTests);
    
    // group("class:PersistentHashBiMap", persistentHashBiMapTests);
    // group("class:PersistentHashMap", persistentHashMapTests);
    // group("class:PersistentList", persistentListTests);
  });
}

main() {
  collectionsTestGroup();
}