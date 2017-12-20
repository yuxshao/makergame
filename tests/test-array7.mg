int array[2][3] = [[1,2,3],[4,5,6]];
int compute[3]() { return array[0]; }
object main {
  event create {
    int arr[3] = compute();
    std::print::i(arr[2]);
    std::game::end();
  }
}
