import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum LocationAssetsType { location, asset, component }

class LocationAssetsTreeHeader extends StatefulWidget {
  final Asset? asset;
  final Location? location;

  const LocationAssetsTreeHeader({
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

  bool get isEnergy {
    return widget.asset != null && widget.asset!.sensorType == 'energy';
  }

  bool get hasAlert {
    return widget.asset != null && widget.asset!.status == 'alert';
  }

  bool get isRoot {
    return (widget.asset?.parentId ?? widget.asset?.locationId ?? widget.location?.parentId) == null;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: isRoot ? 10 : 0),
        SvgPicture.asset(iconFilePath),
        const SizedBox(width: AppMetrics.defaultSpacing),
        Flexible(
          child: Text(
            (widget.asset?.name ?? widget.location?.name)!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        isEnergy
            ? Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: SvgPicture.asset(
                  'lib/assets/bolt_indicator.svg',
                  height: 13,
                ),
              )
            : const SizedBox(),
        hasAlert
            ? Container(
                margin: const EdgeInsets.only(left: 5, top: 5),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
