class Ticker {
  const Ticker();
  Stream<int> tick({required Duration duration, required int ticks}) {
    return Stream.periodic(duration, (x) => ticks - x - 1).take(ticks);
  }
}
