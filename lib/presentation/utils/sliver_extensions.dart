import 'package:flutter/widgets.dart';

extension SliverExtensions on Widget {
  Widget get asSliver => SliverToBoxAdapter(child: this);
}
