import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DevicePixelRatio extends StatelessWidget {
  final double? devicePixelRatio;
  final Widget child;

  DevicePixelRatio({this.devicePixelRatio, required this.child});

  @override
  Widget build(BuildContext context) {
    final windowDevicePixelRatio =
        WidgetsBinding.instance!.window.devicePixelRatio;
    final double devicePixelRatio =
        this.devicePixelRatio ?? windowDevicePixelRatio;
    final ratio = devicePixelRatio / windowDevicePixelRatio;

    return _MediaQueryFromWindow(
      devicePixelRatio: this.devicePixelRatio,
      child: FractionallySizedBox(
        widthFactor: 1 / ratio,
        heightFactor: 1 / ratio,
        child: Transform.scale(scale: ratio, child: child),
      ),
    );
  }
}

/// From widgets/app.dart `WidgetApp`;

/// Builds [MediaQuery] from `window` by listening to [WidgetsBinding].
///
/// It is performed in a standalone widget to rebuild **only** [MediaQuery] and
/// its dependents when `window` changes, instead of rebuilding the entire widget tree.
class _MediaQueryFromWindow extends StatefulWidget {
  final double? devicePixelRatio;
  const _MediaQueryFromWindow(
      {Key? key, required this.child, this.devicePixelRatio})
      : super(key: key);

  final Widget child;

  @override
  _MediaQueryFromWindowsState createState() => _MediaQueryFromWindowsState();
}

class _MediaQueryFromWindowsState extends State<_MediaQueryFromWindow>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  // ACCESSIBILITY

  @override
  void didChangeAccessibilityFeatures() {
    setState(() {
      // The properties of window have changed. We use them in our build
      // function, so we need setState(), but we don't cache anything locally.
    });
  }

  // METRICS

  @override
  void didChangeMetrics() {
    setState(() {
      // The properties of window have changed. We use them in our build
      // function, so we need setState(), but we don't cache anything locally.
    });
  }

  @override
  void didChangeTextScaleFactor() {
    setState(() {
      // The textScaleFactor property of window has changed. We reference
      // window in our build function, so we need to call setState(), but
      // we don't need to cache anything locally.
    });
  }

  // RENDERING
  @override
  void didChangePlatformBrightness() {
    setState(() {
      // The platformBrightness property of window has changed. We reference
      // window in our build function, so we need to call setState(), but
      // we don't need to cache anything locally.
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    if (!kReleaseMode) {
      data = data.copyWith(platformBrightness: debugBrightnessOverride);
    }
    if (widget.devicePixelRatio != null) {
      data = data.copyWith(devicePixelRatio: widget.devicePixelRatio!);
    }
    return MediaQuery(
      data: data,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
