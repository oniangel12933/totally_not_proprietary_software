import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTextButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? assetIcon;
  final bool? isAssetIcon;
  final double? fontSize;
  final double? iconSize;
  final MainAxisAlignment? align;
  final FontWeight? fontWeight;
  final bool? isFilled;
  final bool? isLabelFirst;
  final Color? color;
  final Color? iconColor;
  final Color? bgColor;
  final double? radius;
  final EdgeInsets? padding;
  final Function()? action;

  const MyTextButton(
      {Key? key,
      this.label,
      this.icon,
      this.assetIcon,
      this.isAssetIcon = false,
      this.fontSize = 17,
      this.iconSize,
      this.color = Colors.grey,
      this.isLabelFirst = false,
      this.iconColor,
      this.fontWeight = FontWeight.bold,
      this.align = MainAxisAlignment.end,
      this.isFilled = false,
      this.bgColor = Colors.grey,
      this.radius = 8,
      this.padding = EdgeInsets.zero,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: isFilled!
          ? ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              backgroundColor: MaterialStateProperty.all<Color>(this.bgColor!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(this.radius!),
                ),
              ),
            )
          : TextButton.styleFrom(
              padding: EdgeInsets.zero, minimumSize: Size(50, 30)),
      child: Padding(
        padding: this.padding!,
        child: Row(
          mainAxisAlignment: align!,
          children: [
            if (isLabelFirst! && label != null)
              Text(
                label!,
                style: TextStyle(
                    fontSize: fontSize, color: color, fontWeight: fontWeight),
              ),
            if (isAssetIcon!)
              SvgPicture.asset(assetIcon!,
                  width: iconSize ?? fontSize, color: iconColor ?? color),
            if (!isAssetIcon! && icon != null)
              Icon(icon, size: iconSize ?? fontSize, color: iconColor ?? color),
            if (!isLabelFirst! && label != null)
              Text(
                label!,
                style: TextStyle(
                    fontSize: fontSize, color: color, fontWeight: fontWeight),
              )
          ],
        ),
      ),
      onPressed: action!,
    );
  }
}
