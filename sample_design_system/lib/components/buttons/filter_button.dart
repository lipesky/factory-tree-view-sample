import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample_design_system/common/constants/app_colors.dart';
import 'package:sample_design_system/common/constants/metrics.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool highlighted;
  final String text;
  final String asset;
  final bool enabled;

  const FilterButton({
    required this.onPressed,
    this.highlighted = false,
    required this.text,
    required this.asset,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(        
        backgroundColor: WidgetStatePropertyAll(
            highlighted ? AppColors.filterHighlightColor : Colors.transparent),
        padding:
            const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: highlighted
                ? AppColors.filterHighlightColor
                : AppColors.filterButtonBorder,
            width: 1,
          ),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            colorFilter: highlighted
                ? const ColorFilter.mode(
                    AppColors.titleColor, BlendMode.srcATop)
                : null,
            height: 20,
          ),
          const SizedBox(width: AppMetrics.defaultSpacing / 2),
          Text(
            text,
            style: TextStyle(
              color: highlighted ? AppColors.titleColor : AppColors.textBody,
            ),
          ),
        ],
      ),
    );
  }
}
