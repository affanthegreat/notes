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
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.orange.withOpacity(0.8),
    child: Row(
      children: [
        Icon(Icons.archive, color:light),
        Text("Archive",style: poppins(light,h3,FontWeight.w500),)
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
        Icon(Icons.delete, color:light),
        Text("Delete",style: poppins(light,h3,FontWeight.w500),)
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
        Icon(Icons.archive, color:light),
        Text("Move out from Archive",style: poppins(light,h3,FontWeight.w500),)
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
        Icon(Icons.delete, color:light),
        Text("Delete",style: poppins(light,h3,FontWeight.w500),)
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
    color: Colors.red.withOpacity(0.9),
    child: Row(
      children: [
        Icon(Icons.archive, color:light),
        Text("Delete",style: poppins(light,h3,FontWeight.w500),)
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
        Icon(Icons.delete, color:light),
        Text("Delete",style: poppins(light,h3,FontWeight.w500),)
      ],
    ),
  );
}


