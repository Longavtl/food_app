import 'package:flutter/material.dart';

import '../base_component.dart';

class FListTile extends StatefulWidget {
  const FListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.size = FListTileSize.size48,
    this.onTap,
    this.onLongPress,
    this.tileColor = FColors.grey1,
    this.reversed = false,
    this.rounded = false,
    this.padding,
  }) ;

  final FListTileSize size;
  final VoidCallback ?onTap;
  final VoidCallback ?onLongPress;
  final Widget ?leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Color tileColor;
  final bool reversed;
  final bool rounded;
  final EdgeInsets ?padding;

  @override
  _FListTileState createState() => _FListTileState();
}

class _FListTileState extends State<FListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: widget.size.height,
        ),
        decoration: BoxDecoration(
          color: widget.tileColor,
          borderRadius: widget.rounded
              ? BorderRadius.all(widget.size.borderRadius)
              : null,
        ),
        // height: widget.size.height,
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          textDirection:
              widget.reversed ? TextDirection.rtl : TextDirection.ltr,
          children: [
            if (widget.leading != null)
              Container(
                margin: widget.reversed
                    ? EdgeInsets.fromLTRB(12, 0, 0, 0)
                    : EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: widget.leading,
              ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: DefaultTextStyle(
                        style: FTextStyle.regular14_22
                            .copyWith(color: FColors.grey10),
                        child: widget.title,
                      ),
                    ),
                    if (widget.subtitle != null)
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: DefaultTextStyle(
                          style: FTextStyle.regular12_16
                              .copyWith(color: FColors.grey7),
                          child: widget.subtitle??Container(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.trailing != null)
              if (widget.trailing != null)
                Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: widget.trailing,
                ),
          ],
        ),
      ),
    );
  }
}
