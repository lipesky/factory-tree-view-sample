// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample_design_system/common/constants/app_colors.dart';

AppBar TractianAppBar(BuildContext context, {Widget? title}) {
  title ??= Center( child: SvgPicture.asset('packages/sample_design_system/lib/assets/logo_tractian.svg'));
  return AppBar(
    backgroundColor: AppColors.primary,
    title: title,
    leading: Navigator.of(context).canPop() ? IconButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.chevron_left, color: AppColors.titleColor,),
    ) : null,
    actions: Navigator.of(context).canPop() ? [
      // just to always centralize titles
       IgnorePointer(
        ignoring: true,
         child: IconButton(
               onPressed: (){
          Navigator.of(context).pop();
               },
               icon: const Icon(Icons.chevron_left, color: Colors.transparent,),
             ),
       ),
    ] : null,
  );

}
