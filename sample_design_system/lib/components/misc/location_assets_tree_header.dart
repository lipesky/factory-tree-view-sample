import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample_design_system/common/constants/metrics.dart';
import 'package:sample_design_system/components/misc/location_assets_item_type.dart';

class LocationAssetsTreeHeader extends StatefulWidget {
  final bool isEnergy;
  final bool hasAlert;
  final bool isRoot;
  final LocationAssetsType type;
  final String name;

  const LocationAssetsTreeHeader({
    this.isEnergy = false,
    this.hasAlert = false,
    this.isRoot = false,
    required this.type,
    required this.name,
    super.key,
  });
  @override
  State<LocationAssetsTreeHeader> createState() =>
      _LocationAssetsTreeHeaderState();
}

class _LocationAssetsTreeHeaderState extends State<LocationAssetsTreeHeader> {
  bool expanded = false;
  
  String get iconFilePath {
    String filename = 'packages/sample_design_system/lib/assets/';
    switch (widget.type) {
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
        SizedBox(width: widget.isRoot ? 10 : 0),
        SvgPicture.asset(iconFilePath),
        const SizedBox(width: AppMetrics.defaultSpacing),
        Flexible(
          child: Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        widget.isEnergy
            ? Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: SvgPicture.asset(
                  'packages/sample_design_system/lib/assets/bolt_indicator.svg',
                  height: 13,
                ),
              )
            : const SizedBox(),
        widget.hasAlert
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
