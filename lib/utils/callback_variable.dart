/// Wrapper around variable with ability call callbacks on change
class CallbackVariable<T> {
  late T value;
  final Map<int, void Function()> _callbacks;

  CallbackVariable(this.value) : _callbacks = {};

  T get() => value;

  operator() => value;

  /// Calls all callbacks
  void update() {
    _callbacks.forEach((key, value) => value());
  }

  /// Adds callback and returns its index
  int addCallback(void Function() callback) {
    int index = _callbacks.length;
    _callbacks[index] = callback;
    return index;
  }

  /// Removes callback
  void removeCallback(int index) {
    _callbacks.remove(index);
  }
}
