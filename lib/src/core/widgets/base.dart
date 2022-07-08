import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/usecases/navigator/navigator_push_usecase.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/pages/add_pet_page.dart';

class BaseWithScaffold extends StatefulWidget {
  final String title;
  final bool hasRightIcon;
  final IconData icon;
  final void Function() iconPressed;
  final Widget? bottomWidget;
  final Widget child;

  const BaseWithScaffold({
    Key? key,
    required this.title,
    required this.hasRightIcon,
    required this.icon,
    required this.iconPressed,
    this.bottomWidget,
    required this.child,
  }) : super(key: key);

  @override
  State<BaseWithScaffold> createState() => _BaseWithScaffoldState();
}

class _BaseWithScaffoldState extends State<BaseWithScaffold> {
  final NavigatorPushUseCase navigatorPushUseCase = NavigatorPushUseCase();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.baseColor,
        bottomNavigationBar: SafeArea(
          child: widget.bottomWidget ?? const SizedBox.shrink(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
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
                            child: IconButton(
                              onPressed: widget.iconPressed,
                              icon: Icon(widget.icon),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iconSize: 34,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          widget.hasRightIcon
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () async {
                                      await navigatorPushUseCase(
                                          NavigatorPushParam(
                                        route: MaterialPageRoute(
                                          builder: (context) =>
                                              const AddPetPage(),
                                        ),
                                        context: context,
                                      ));
                                    },
                                    icon: const Icon(Icons.add),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    iconSize: 34,
                                  ),
                                )
                              : const SizedBox.shrink(),
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
