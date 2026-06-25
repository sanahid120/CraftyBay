import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/app_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo( {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetPaths.logoSvg,height: 150,width: 150,);
  }
}