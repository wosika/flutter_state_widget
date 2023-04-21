library state_widget;

import 'package:flutter/widgets.dart';
import 'package:state_widget/src/empty_state_widget.dart';
import 'package:state_widget/src/error_state_widget.dart';
import 'package:state_widget/src/loading_state_widget.dart';

/// 状态布局
typedef StateWidgetBuilder = Widget? Function(
    {VoidCallback? onRetry, String? message});

enum StateType {
  ///错误
  error,

  ///页面为空
  empty,

  ///加载中
  loading,

  ///加载完成
  success
}

class StateWidget extends StatefulWidget {
  //全局配置
  static StateWidgetBuilder? staticErrorWidgetBuilder;
  static StateWidgetBuilder? stateEmptyWidgetBuilder;
  static StateWidgetBuilder? stateLoadingWidgetBuilder;

  //提供全局初始化配置
  static void config(
      {StateWidgetBuilder? errorWidgetBuilder,
      StateWidgetBuilder? emptyWidgetBuilder,
      StateWidgetBuilder? loadingWidgetBuilder}) {
    staticErrorWidgetBuilder = errorWidgetBuilder;
    stateEmptyWidgetBuilder = emptyWidgetBuilder;
    stateLoadingWidgetBuilder = loadingWidgetBuilder;
  }

  //状态
  final StateType stateType;

  //局部配置
  final Widget? errorWidget;
  final Widget child;
  final Widget? emptyWidget;
  final Widget? loadingWidget;

  //错误回调
  final VoidCallback? onRetry;

  //提示信息
  final String? message;

  const StateWidget(
      {Key? key,
      required this.child,
      required this.stateType,
      this.errorWidget,
      this.emptyWidget,
      this.loadingWidget,
      this.onRetry,
      this.message})
      : super(key: key);

  @override
  StateWidgetState createState() => StateWidgetState();
}

class StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity, child: _buildWidget(widget.stateType));
  }

  Widget _buildDefaultWidget(StateType type,
      {String? message, VoidCallback? onRetry}) {
    switch (type) {
      case StateType.error:
        return _buildDefaultErrorWidget(onRetry: onRetry, message: message);
      case StateType.empty:
        return _buildDefaultEmptyWidget(message: message);
      case StateType.loading:
        return _buildDefaultLoadingWidget(message: message);
      case StateType.success:
        return Container();
    }
  }

  Widget _buildWidget(StateType type) {
    switch (type) {
      case StateType.error:
        return widget.errorWidget ??
            StateWidget.staticErrorWidgetBuilder
                ?.call(onRetry: widget.onRetry, message: widget.message) ??
            _buildDefaultWidget(type,
                onRetry: widget.onRetry, message: widget.message);
      case StateType.empty:
        return widget.emptyWidget ??
            StateWidget.stateEmptyWidgetBuilder
                ?.call(message: widget.message) ??
            _buildDefaultWidget(type, message: widget.message);
      case StateType.loading:
        return widget.loadingWidget ??
            StateWidget.stateLoadingWidgetBuilder
                ?.call(message: widget.message) ??
            _buildDefaultWidget(type);
      case StateType.success:
        return widget.child;
    }
  }

  //构建默认的错误布局
  Widget _buildDefaultErrorWidget({VoidCallback? onRetry, String? message}) {
    return ErrorStateWidget(onRetry: onRetry, message: message);
  }

  Widget _buildDefaultEmptyWidget({String? message}) {
    return EmptyStateWidget(message: message);
  }

  Widget _buildDefaultLoadingWidget({String? message}) {
    return LoadingStateWidget(message: message);
  }
}

extension StateWidgetExt on Widget {
  ///页面加载中
  Widget state({
    Key? key,
    StateType stateType = StateType.loading,
    Widget? loadingWidget,
    Widget? errorWidget,
    Widget? emptyWidget,
  }) {
    return StateWidget(
      key: key,
      stateType: stateType,
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      emptyWidget: emptyWidget,
      child: this,
    );
  }
}
