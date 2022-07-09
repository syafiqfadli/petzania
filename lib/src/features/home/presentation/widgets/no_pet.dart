import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/usecases/navigator/navigator_push_usecase.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/core/widgets/refresh.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/pages/add_pet_page.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/refresh_home_cubit.dart';

class NoPet extends StatefulWidget {
  const NoPet({Key? key}) : super(key: key);

  @override
  State<NoPet> createState() => _NoPetState();
}

class _NoPetState extends State<NoPet> {
  final NavigatorPushUseCase navigatorPushUseCase = NavigatorPushUseCase();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: CustomRefresh(
        onRefresh: _refresh,
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SizedBox(height: height * 0.1),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "You don't have any pet yet",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryColor,
                  fixedSize: const Size(190, 50),
                ),
                onPressed: () async {
                  await navigatorPushUseCase(
                    NavigatorPushParam(
                      route: MaterialPageRoute(
                        builder: (context) => const AddPetPage(),
                      ),
                      context: context,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "Add Pet",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await context.read<RefreshHomeCubit>().refresh();
  }
}
