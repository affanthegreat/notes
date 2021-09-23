import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 5),
        //margin: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.8),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Row(
          children: [
            Icon(Icons.archive, color: light),
            Text(
              "Archive",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        //margin: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: light),
            Text(
              "Delete",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );
}

class DismissibleWidget2<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget2({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.orange.withOpacity(0.8),
        child: Row(
          children: [
            Icon(Icons.archive, color: light),
            Text(
              "Move out from Archive",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red.withOpacity(0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: light),
            Text(
              "Delete",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );
}

class DismissibleWidget3<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget3({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.9), borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Icon(Icons.delete, color: light),
            Text(
              "Delete",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.9), borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: light),
            Text(
              "Delete",
              style: poppins(light, h3, FontWeight.w500),
            )
          ],
        ),
      );
}

class DismissibleWidget4<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget4({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        color: Colors.grey.withOpacity(0.1),
      );

  Widget buildSwipeActionRight() => Container(
        color: Colors.grey.withOpacity(0.1),
      );
}
