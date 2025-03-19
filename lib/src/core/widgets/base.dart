import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petzania/src/core/util/colors.dart';

class BaseWithScaffold extends StatefulWidget {
  final String title;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Widget? bottomWidget;
  final Widget child;

  const BaseWithScaffold({
    super.key,
    required this.title,
    required this.prefixIcon,
    this.suffixIcon,
    this.bottomWidget,
    required this.child,
  });

  @override
  State<BaseWithScaffold> createState() => _BaseWithScaffoldState();
}

class _BaseWithScaffoldState extends State<BaseWithScaffold> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.baseColor,
        bottomNavigationBar: SafeArea(
          child: widget.bottomWidget ?? const SizedBox.shrink(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: widget.prefixIcon,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: width * 0.6,
                              child: Center(
                                child: AutoSizeText(
                                  widget.title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.suffixIcon,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
