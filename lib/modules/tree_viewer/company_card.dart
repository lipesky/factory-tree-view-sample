import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyCard extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  const CompanyCard({
    required this.onTap,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: const Color(0xff2188FF),
          child: Padding(
            padding: const EdgeInsets.all(AppMetrics.defaultSpacing * 2),
            child: Row(
              children: [
                SvgPicture.asset('lib/assets/company.svg'),
                const SizedBox(width: 20),
                Text(
                  '$name Unit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
