import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';
class ExternalBankLogoCircle extends StatelessWidget {
  const ExternalBankLogoCircle({
    super.key,
    required this.logo,
  });

  final String logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultLeadingPngListTileSize,
      height: defaultLeadingPngListTileSize,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all( Radius.circular(50.0)),
        border: Border.all(
          color: dividerColor,
        ),
      ),
      child: Image.network(
        logo,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
