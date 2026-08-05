import 'package:flutter/widgets.dart';

/// Extension that lets any regular [Widget] be used inside a
/// [CustomScrollView]'s `slivers` list by wrapping it into a sliver.
extension SliverExtensions on Widget {
  /// Wraps this widget into a [SliverToBoxAdapter] so it can be placed
  /// directly among other slivers.
  Widget get asSliver => SliverToBoxAdapter(child: this);
}
