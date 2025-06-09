import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  final double? height;
  final Function? backClick;
  const BasicAppBar({
    this.title,
    this.hideBack = false,
    this.action,
    this.backgroundColor,
    this.height,
    this.backClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0, // 设置AppBar阴影高度为0，去除默认阴影效果
      centerTitle: true, // 标题居中显示
      automaticallyImplyLeading: false, // 禁用自动生成的返回按钮
      toolbarHeight: height ?? 80,
      title: title ?? const Text(''),
      titleSpacing: 0,
      actions: [action ?? Container()],
      leading: hideBack
          ? null
          : IconButton(
              icon: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppColors.secondBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (backClick != null) {
                  backClick!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
    );
  }

  // 这样设计允许：
  // - 外部调用时可以通过 height 参数自定义AppBar高度
  // - 不传 height 时使用合理的默认高度(80)
  @override
  Size get preferredSize => Size.fromHeight(height ?? 80);
}
