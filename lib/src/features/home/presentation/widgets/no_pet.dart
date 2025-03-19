import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/colors.dart';
import '../../../../core/widgets/refresh.dart';
import '../../../add_pet/presentation/pages/add_pet_page.dart';
import '../cubit/refresh_home_cubit.dart';

class NoPet extends StatefulWidget {
  const NoPet({Key? key}) : super(key: key);

  @override
  State<NoPet> createState() => _NoPetState();
}

class _NoPetState extends State<NoPet> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: CustomRefresh(
        predicate: (_) => true,
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
                  backgroundColor: AppColor.primaryColor,
                  fixedSize: const Size(190, 50),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPetPage(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
