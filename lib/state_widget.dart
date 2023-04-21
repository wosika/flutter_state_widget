library state_widget;

import 'package:flutter/widgets.dart';


/// 状态布局
typedef ErrorWidgetBuilder = Widget? Function();
typedef SuccessWidgetBuilder = Widget? Function();
typedef EmptyWidgetBuilder = Widget? Function();
typedef LoadingWidgetBuilder = Widget? Function();
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
  static ErrorWidgetBuilder? staticErrorWidgetBuilder;
  static EmptyWidgetBuilder? stateEmptyWidgetBuilder;
  static LoadingWidgetBuilder? stateLoadingWidgetBuilder;

  //提供全局初始化配置
  static void config(
      {ErrorWidgetBuilder? errorWidgetBuilder,
        EmptyWidgetBuilder? emptyWidgetBuilder,
        LoadingWidgetBuilder? loadingWidgetBuilder}) {
    staticErrorWidgetBuilder = errorWidgetBuilder;
    stateEmptyWidgetBuilder = emptyWidgetBuilder;
    stateLoadingWidgetBuilder = loadingWidgetBuilder;
  }

  //状态
  final StateType type;

  //局部配置
  final Widget? errorWidget;
  final Widget? successWidget;
  final Widget? emptyWidget;
  final Widget? loadingWidget;

  const StateWidget(
      {Key? key,
        required this.type,
        this.errorWidget,
        this.successWidget,
        this.emptyWidget,
        this.loadingWidget})
      : super(key: key);

  @override
  StateWidgetState createState() => StateWidgetState();
}

class StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: _buildWidget(widget.type));
  }

  Widget _buildDefaultWidget(StateType type) {
    switch (type) {
      case StateType.error:
        break;
      case StateType.empty:
        break;
      case StateType.loading:
        break;
      case StateType.success:
        break;
    }
    return Container();
  }

  _buildWidget(StateType type) {
    switch (type) {
      case StateType.error:
        return widget.errorWidget ??
            StateWidget.staticErrorWidgetBuilder?.call() ??
            _buildDefaultWidget(type);
      case StateType.empty:
        return widget.emptyWidget ??
            StateWidget.stateEmptyWidgetBuilder?.call() ??
            _buildDefaultWidget(type);
      case StateType.loading:
        return widget.loadingWidget ??
            StateWidget.stateLoadingWidgetBuilder?.call() ??
            _buildDefaultWidget(type);
      case StateType.success:
        return widget.successWidget ?? _buildDefaultWidget(type);
    }
  }
}


extension StateWidgetExt on Widget {
  ///页面加载中
  Widget state({
    Key? key,
    StateType type = StateType.loading,
    Widget? loadingWidget,
    Widget? errorWidget,
    Widget? emptyWidget,
  }) {
    return StateWidget(
      key: key,
      type: type,
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      emptyWidget: emptyWidget,
      successWidget: this,
    );
  }
}