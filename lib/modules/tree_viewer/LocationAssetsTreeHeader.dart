import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum LocationAssetsType { location, asset, component }

class LocationAssetsTreeHeader extends StatefulWidget {
  final bool isRoot;
  final Asset? asset;
  final Location? location;

  const LocationAssetsTreeHeader({
    this.isRoot = false,
    this.asset,
    this.location,
    super.key,
  }) : assert(
            (asset != null || location != null) &&
                !(asset != null && location != null),
            'you must provide one (and only one) of asset or location');
  @override
  State<LocationAssetsTreeHeader> createState() =>
      _LocationAssetsTreeHeaderState();
}

class _LocationAssetsTreeHeaderState extends State<LocationAssetsTreeHeader> {
  bool expanded = false;

  // only one can be provided
  LocationAssetsType get type {
    if (widget.location != null) {
      return LocationAssetsType.location;
    }
    if (widget.asset!.sensorType != null) {
      return LocationAssetsType.component;
    }
    return LocationAssetsType.asset;
  }

  String get iconFilePath {
    String filename = 'lib/assets/';
    switch (type) {
      case LocationAssetsType.location:
        filename += 'location';
        break;
      case LocationAssetsType.component:
        filename += 'component';
        break;
      default:
        filename += 'asset';
    }
    filename += '.svg';
    return filename;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconFilePath),
        const SizedBox(width: AppMetrics.defaultSpacing),
        Expanded(
          child: Text(
            (widget.asset?.name ?? widget.location?.name)!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
