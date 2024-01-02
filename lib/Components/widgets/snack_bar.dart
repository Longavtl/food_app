

import 'package:flutter/material.dart';
import 'package:food_app/Components/styles/snack_bar_style.dart';


import '../base_component.dart';
import '../styles/text_style.dart';
import 'icon.dart';
import 'list_tile.dart';
import 'media_view.dart';

class FSnackBar extends StatelessWidget {
  const FSnackBar({
    super.key,
    required this.title,
    this.action,
    this.status = FSnackBarStatus.infor,
    this.isSoft = true,
  }) ;

  final Widget title;
  final Widget? action;
  final bool isSoft;
  final FSnackBarStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSoft ? status.secondaryColor : status.primaryColor,
        borderRadius: isSoft ? BorderRadius.circular(8) : null,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 0,
        minLeadingWidth: 12,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FIcon(
              icon: status.icon,
              color: isSoft ? status.primaryColor : status.secondaryColor,
            ),
          ],
        ),
        title: DefaultTextStyle(
          style: FTextStyle.regular14_22.copyWith(
            color: isSoft ? status.primaryColor : status.secondaryColor,
          ),
          child: title,
        ),
        trailing: action,
      ),
    );
    Container(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      decoration: BoxDecoration(
        color: isSoft ? status.secondaryColor : status.primaryColor,
        borderRadius: isSoft ? BorderRadius.circular(8) : null,
      ),
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: FMediaView(
              shape: FBoxShape.rect,
              backgroundColor: FColors.transparent,
              child: Center(
                child: FIcon(
                  icon: status.icon,
                  color: isSoft ? status.primaryColor : status.secondaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: DefaultTextStyle(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.regular14_22.copyWith(
                color: isSoft ? status.primaryColor : status.secondaryColor,
                // height: 1,
              ),
              child: title,
            ),
          ),
          Container(child: action)
        ],
      ),
    );
  }
}
