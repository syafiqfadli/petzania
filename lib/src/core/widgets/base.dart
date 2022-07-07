import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class BaseWithScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool hasRightIcon;
  final IconData icon;
  final void Function() iconPressed;

  const BaseWithScaffold({
    Key? key,
    required this.title,
    required this.child,
    required this.hasRightIcon,
    required this.icon,
    required this.iconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.baseColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
          child: Column(
            children: [
              hasRightIcon
                  ? HasAddAppBar(
                      title: title,
                      icon: icon,
                      iconPressed: iconPressed,
                    )
                  : NoAddAppBar(title: title),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class HasAddAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() iconPressed;

  const HasAddAppBar({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: iconPressed,
            icon: Icon(icon),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 34,
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 34,
          ),
        ],
      ),
    );
  }
}

class NoAddAppBar extends StatelessWidget {
  final String title;

  const NoAddAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 34,
          ),
          const Spacer(),
          // TODO: Fix center issue
          Padding(
            padding: EdgeInsets.only(right: width * 0.295),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
