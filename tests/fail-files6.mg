// update: includes itself so it fails
// old: contains namespace definition that involves itself
namespace file = open "../test-helpers/recursive.mg";

object main { }
