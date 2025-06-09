import 'dart:async';
import 'dart:ui';

class DebounceThrottleHelper {
  Timer? _debounceTimer;
  bool _isThrottling = false;

  /// 执行防抖操作：在 [duration] 时间内无再次调用，才执行 [action]
  void runDebounce(VoidCallback action,
      {Duration duration = const Duration(milliseconds: 500)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, action);
  }

  /// 执行限流操作：在 [duration] 时间内只允许一次执行 [action]
  void runThrottle(VoidCallback action,
      {Duration duration = const Duration(milliseconds: 500)}) {
    if (_isThrottling) return;
    _isThrottling = true;
    action();
    Timer(duration, () {
      _isThrottling = false;
    });
  }

  /// 清理资源（可在 Cubit/Controller 的 dispose/close 中调用）
  void dispose() {
    _debounceTimer?.cancel();
  }
}
