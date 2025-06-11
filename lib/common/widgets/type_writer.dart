import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterWithScroll extends StatefulWidget {
  // 要显示的文字内容  // 表示するテキスト内容
  final String text;
  // 每个字符出现的间隔时间，默认50毫秒  // 各文字が表示される間隔時間（デフォルトは50ミリ秒）
  final Duration charDuration;
  // 用于控制滚动的 ScrollController  // スクロールを制御するScrollController
  final ScrollController scrollController;
  // 动画完成时的回调函数，可选  // アニメーション完了時のコールバック関数（オプション）
  final VoidCallback? onComplete;
  // 文本样式，可选  // テキストスタイル（オプション）
  final TextStyle? style;

  const TypewriterWithScroll({
    Key? key,
    required this.text,
    required this.scrollController,
    this.charDuration = const Duration(milliseconds: 50),
    this.onComplete,
    this.style,
  }) : super(key: key);

  @override
  _TypewriterWithScrollState createState() => _TypewriterWithScrollState();
}

class _TypewriterWithScrollState extends State<TypewriterWithScroll> {
  String _displayText = ''; // 当前展示的文本（逐字添加）  // 現在表示されているテキスト（1文字ずつ追加）
  late int _currentIndex; // 当前已经显示了多少字符的索引  // 現在表示されている文字のインデックス
  Timer? _timer; // 定时器，用来定时显示下一个字符  // タイマー、次の文字を定期的に表示するために使用
  bool _isCompleted = false; // 标记文字动画是否已经完成  // テキストアニメーションが完了したかどうかのフラグ

  @override
  void initState() {
    super.initState();
    _currentIndex = 0; // 从第0个字符开始显示  // 0文字目から表示を開始
    _startTyping(); // 启动逐字显示动画  // タイピングアニメーションを開始
  }

  /// 开始逐字显示文本  // テキストを1文字ずつ表示開始
  void _startTyping() {
    _isCompleted = false; // 动画重置为未完成状态  // アニメーション完了状態をリセット

    // 每隔 charDuration 触发一次  // charDurationごとに繰り返し実行
    _timer = Timer.periodic(widget.charDuration, (timer) {
      // 如果还没显示完所有字符  // まだ全ての文字を表示していない場合
      if (_currentIndex < widget.text.length) {
        setState(() {
          _currentIndex++; // 显示更多一个字符  // 文字の表示数を1増やす
          _displayText = widget.text.substring(0, _currentIndex);
        });

        // 确保文本更新后，滚动视图滚动到底部  // テキスト更新後にスクロールを一番下まで移動
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.scrollController.hasClients) {
            // 只在每5个字符或最后一个字符时滚动，避免频繁滚动
            if (_currentIndex % 5 == 0 || _currentIndex == widget.text.length) {
              widget.scrollController.animateTo(
                widget
                    .scrollController
                    .position
                    .maxScrollExtent, // 滚动到底部  // スクロールを一番下へ
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutQuart,
              );
            }
          }
        });
      } else {
        // 显示完成，调用完成处理  // 表示完了、完了処理を呼び出す
        _completeTyping();
      }
    });
  }

  /// 文字全部显示完成的处理  // 全ての文字の表示完了処理
  void _completeTyping() {
    _timer?.cancel(); // 取消定时器，停止动画  // タイマーをキャンセルしてアニメーションを停止

    if (!_isCompleted) {
      setState(() {
        _displayText = widget.text; // 立即显示完整文本  // テキストを一気に全部表示
        _isCompleted = true; // 标记动画完成  // アニメーション完了をマーク
      });

      // 完成后确保滚动到底部  // 完了後にスクロールを一番下へ移動
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.scrollController.hasClients) {
          widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutQuart,
          );
        }
      });

      // 如果有回调，调用它通知外部动画完成  // コールバックがあれば呼び出して外部に完了通知
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    }
  }

  /// 点击时触发，快速显示完整文本  // タップ時に呼ばれ、テキストをすぐに全部表示
  void _onTap() {
    if (!_isCompleted) {
      _completeTyping();
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterWithScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当传入的文本内容发生变化时，重置动画重新开始  // テキスト内容が変わったらアニメーションをリセットして再開
    if (oldWidget.text != widget.text) {
      _timer?.cancel(); // 取消旧动画  // 既存のタイマーをキャンセル
      _currentIndex = 0; // 重置索引  // インデックスをリセット
      _displayText = ''; // 清空显示内容  // 表示テキストを空にする
      _startTyping(); // 重新开始动画  // アニメーションを再スタート
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // 确保页面销毁时取消定时器避免内存泄漏  // ウィジェット破棄時にタイマーをキャンセルしてメモリリーク防止
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap, // 点击文本时触发快速显示全部  // テキストタップ時に全表示へ切り替え
      child: Text(
        _displayText, // 显示当前逐字的文本  // 現在の文字表示テキスト
        style: widget.style, // 支持自定义文本样式  // カスタムテキストスタイルをサポート
      ),
    );
  }
}
