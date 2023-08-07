import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/shared/widgets/skeletton/shimmer.dart';
import 'package:lumiere/app/shared/widgets/skeletton/shimmer_loading.dart';

class ShimmerProvider extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  const ShimmerProvider(
      {super.key, required this.isLoading, required this.child});

  @override
  State<ShimmerProvider> createState() => _ShimmerProviderState();
}

class _ShimmerProviderState extends State<ShimmerProvider> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ShimmerLoading(
        isLoading: widget.isLoading,
        child: widget.child,
      ),
    );
  }
}
