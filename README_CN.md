[![pub package](https://img.shields.io/pub/v/state_widget.svg)](https://pub.dev/packages/state_widget)

# StateWidget 组件

`StateWidget` 组件是一个通用的状态布局组件，可以根据不同的状态（例如加载中、加载失败、空数据等）来显示不同的布局。

## 使用方法

使用 `StateWidget` 组件需要传入以下参数：

- `stateType`: 状态布局的类型，枚举类型为 `StateType`，包括以下几种值：
    - `loading`: 加载中状态
    - `empty`: 空数据状态
    - `error`: 加载失败状态
    - `success`: 内容展示状态
- `message`: 当状态布局的类型为 `empty` 或 `error` 时，可以传入一段文本说明具体的状态信息。
- `onRetry`: 当状态布局的类型为 `error` 时，可以传入一个回调函数，用于重新尝试加载数据。
- `child`: 当状态布局的类型为 `success` 时，需要传入一个子组件用于展示内容。

示例代码如下：

```dart
//1.直接使用
    StateWidget(
      stateType: stateType,
      loadingWidgetBuilder: (_, __) => const Text('Loading'),
      emptyWidgetBuilder: (message, __) => const Text('Empty'),
      errorWidgetBuilder: (message, onRetry) => TextButton(
        onPressed: onRetry,
        child: const Text("点击重试"),
      ),
      onRetry: () {
        //retry
        setState(() {
          stateType = StateType.loading;
        });
      },
      message: "提示信息",
      child: const Text('Hello World'),
    );

//2.使用拓展函数.state来构建
     Text('Hello World').state(
        stateType: stateType,
        loadingWidgetBuilder: (_, __) => const Text('Loading'),
        emptyWidgetBuilder: (message, __) => const Text('Empty'),
        errorWidgetBuilder: (message, onRetry) => TextButton(
              onPressed: onRetry,
              child: const Text("点击重试"),
            ),
        onRetry: () {
          //retry
          setState(() {
            stateType = StateType.loading;
          });
        },
        message: "提示信息");

```

## 全局配置

可以通过以下方式来配置 `StateWidget` 组件的全局配置信息：

```dart
    //全局初始化状态布局
    StateWidget.config(
        errorWidgetBuilder: (String? message, VoidCallback? onRetry) => Column(
              children: [
                Text(message ?? "Error"),
                TextButton(onPressed: onRetry, child: const Text("点击重试"))
              ],
            ),
        emptyWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Empty"),
        loadingWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Loading"));

```

其中 `StateWidgetConfig` 是一个配置类，包含以下参数：

- `emptyWidgetBuilder`: 构建空数据状态下的自定义组件。
- `errorWidgetBuilder`: 构建加载失败状态下的自定义组件。
- `loadingWidgetBuilder`: 构建加载中状态下的自定义组件。

### 配置优先级 局部配置 > 全局配置 