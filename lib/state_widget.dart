library state_widget;

import 'package:flutter/widgets.dart';
import 'package:state_widget/src/empty_state_widget.dart';
import 'package:state_widget/src/error_state_widget.dart';
import 'package:state_widget/src/loading_state_widget.dart';

/// 状态布局
typedef StateWidgetBuilder = Widget? Function(
    String? message, VoidCallback? onRetry);

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
  final StateWidgetBuilder? errorWidgetBuilder;
  final Widget child;
  final StateWidgetBuilder? emptyWidgetBuilder;
  final StateWidgetBuilder? loadingWidgetBuilder;

  //错误回调
  final VoidCallback? onRetry;

  //提示信息
  final String? message;

  const StateWidget(
      {Key? key,
      required this.child,
      required this.stateType,
      this.errorWidgetBuilder,
      this.emptyWidgetBuilder,
      this.loadingWidgetBuilder,
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
        return widget.errorWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
            StateWidget.staticErrorWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
            _buildDefaultWidget(type,
                onRetry: widget.onRetry, message: widget.message);
      case StateType.empty:
        return widget.emptyWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
            StateWidget.stateEmptyWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
            _buildDefaultWidget(type, message: widget.message);
      case StateType.loading:
        return widget.loadingWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
            StateWidget.stateLoadingWidgetBuilder
                ?.call(widget.message, widget.onRetry) ??
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
    StateWidgetBuilder? loadingWidgetBuilder,
    StateWidgetBuilder? errorWidgetBuilder,
    StateWidgetBuilder? emptyWidgetBuilder,
    //重试
    VoidCallback? onRetry,
    //提示信息
    String? message,
  }) {
    return StateWidget(
      key: key,
      stateType: stateType,
      loadingWidgetBuilder: loadingWidgetBuilder,
      errorWidgetBuilder: errorWidgetBuilder,
      emptyWidgetBuilder: emptyWidgetBuilder,
      onRetry: onRetry,
      message: message,
      child: this,
    );
  }
}
