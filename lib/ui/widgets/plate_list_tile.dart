import 'package:flutter/material.dart';
import 'package:pizza_simplified/ui/utils/utils.dart';

class PlateListTile extends StatefulWidget {
  final Color backgroundColor;
  final int index;
  final PageController controller;
  final int initialPage;

  const PlateListTile({
    Key key,
    this.backgroundColor,
    this.index,
    this.controller,
    this.initialPage,
  }) : super(key: key);

  @override
  _PlateListTileState createState() => _PlateListTileState();
}

class _PlateListTileState extends State<PlateListTile>
    with TickerProviderStateMixin {
  Animation<double> xOffsetAnimation;
  void Function() listen;

  void _setState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_setState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_setState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double diff;
    if (widget.controller.position.haveDimensions) {
      if (widget.index == 0 && widget.controller.page % 6 > 1)
        diff = ((widget.controller.page % 6) - 6).clamp(-1.0, 1.0);
      else
        diff = ((widget.controller.page % 6) - widget.index).clamp(-1.0, 1.0);
    } else {
      diff = widget.index == (widget.initialPage % 6) ? 0.0 : 1.0;
    }
    double absDiff = diff < 0 ? diff * -1 : diff;

    Offset shadowOffset = Offset(0, (1 - absDiff) * 35 + 15);

    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: shadowOffset,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(99999)),
              ),
            );
          }),
          Text(
            "Page ${widget.index + 1}",
            style: TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}
