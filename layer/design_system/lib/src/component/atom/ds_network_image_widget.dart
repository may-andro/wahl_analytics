import 'dart:async';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class DSNetworkImageWidget extends StatefulWidget {
  const DSNetworkImageWidget({
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.shape,
    this.borderRadius,
    this.autoSizeImage = false,
    this.loadingWidget,
    this.errorWidget,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final bool autoSizeImage;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  State<DSNetworkImageWidget> createState() => _DSNetworkImageWidgetState();
}

class _DSNetworkImageWidgetState extends State<DSNetworkImageWidget> {
  ExtendedImageState? imageState;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (imageState?.extendedImageLoadState == LoadState.failed &&
          result.none((s) => s == ConnectivityResult.none)) {
        imageState?.reLoadImage();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.url;
    if (imageUrl.isEmpty) {
      return _ErrorWidget(height: widget.height, width: widget.width);
    }

    return ExtendedImage.network(
      imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      shape: widget.shape,
      borderRadius: widget.borderRadius,
      loadStateChanged: (ExtendedImageState state) {
        imageState = state;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return widget.loadingWidget ??
                const Center(child: CircularProgressIndicator());
          case LoadState.completed:
            if (widget.autoSizeImage) {
              return AspectRatio(
                aspectRatio:
                    state.extendedImageInfo!.image.width /
                    state.extendedImageInfo!.image.height,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: widget.fit,
                ),
              );
            }
            return state.completedWidget;
          case LoadState.failed:
            return widget.errorWidget ??
                _ErrorWidget(
                  height: widget.height,
                  width: widget.width,
                  onTap: state.reLoadImage,
                );
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({this.width, this.height, this.onTap});

  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        color: context.colorPalette.neutral.transparent.color,
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Icon(onTap != null ? Icons.refresh : Icons.broken_image);
          },
        ),
      ),
    );
  }
}
