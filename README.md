[![pub package](https://img.shields.io/pub/v/state_widget.svg)](https://pub.dev/packages/state_widget)
# StateWidget

# Chinese Document: [README](./README_CN.md)

The `StateWidget` component is a generic state layout component that can display different layouts based on various states (such as loading, load failure, empty data, etc.).

## Usage

To use the `StateWidget` component, the following parameters need to be provided:

- `stateType`: The type of state layout, enumerated as `StateType`, including the following values:
    - `loading`: Loading state
    - `empty`: Empty data state
    - `error`: Load failure state
    - `success`: Content display state
- `message`: When the state layout type is `empty` or `error`, a text message can be passed to describe the specific state information.
- `onRetry`: When the state layout type is `error`, a callback function can be passed to retry loading the data.
- `child`: When the state layout type is `success`, a child component needs to be passed to display the content.

Example code:

```dart
//1. Direct usage
    StateWidget(
      stateType: stateType,
      loadingWidgetBuilder: (_, __) => const Text('Loading'),
      emptyWidgetBuilder: (message, __) => const Text('Empty'),
      errorWidgetBuilder: (message, onRetry) => TextButton(
        onPressed: onRetry,
        child: const Text("Click to Retry"),
      ),
      onRetry: () {
        //retry
        setState(() {
          stateType = StateType.loading;
        });
      },
      message: "Prompt message",
      child: const Text('Hello World'),
    );

//2. Using the extension function .state to build
     Text('Hello World').state(
        stateType: stateType,
        loadingWidgetBuilder: (_, __) => const Text('Loading'),
        emptyWidgetBuilder: (message, __) => const Text('Empty'),
        errorWidgetBuilder: (message, onRetry) => TextButton(
              onPressed: onRetry,
              child: const Text("Click to Retry"),
            ),
        onRetry: () {
          //retry
          setState(() {
            stateType = StateType.loading;
          });
        },
        message: "Prompt message");

```

## Global Configuration

The global configuration of the `StateWidget` component can be set as follows:

```dart
// Global initialization of state layout
    StateWidget.config(
        errorWidgetBuilder: (String? message, VoidCallback? onRetry) => Column(
              children: [
                Text(message ?? "Error"),
                TextButton(onPressed: onRetry, child: const Text("Click to Retry"))
              ],
            ),
        emptyWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Empty"),
        loadingWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Loading"));

```

The `StateWidgetConfig` is a configuration class that includes the following parameters:

- `emptyWidgetBuilder`: Custom component for building the empty data state.
- `errorWidgetBuilder`: Custom component for building the load failure state.
- `loadingWidgetBuilder`: Custom component for building the loading state.

### Configuration Priority

Local configuration > Global configuration