class Timer {
  const Timer();
  Stream<int> tick({required Duration duration, int start = 0}) {
    return Stream.periodic(duration, (x) => start + x + 1);
  }
}
