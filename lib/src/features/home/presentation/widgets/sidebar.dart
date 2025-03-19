import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/services/dialog_service.dart';
import '../../../../core/util/colors.dart';
import '../../home_injector.dart';
import '../cubit/get_pet_list_cubit.dart';
import '../cubit/remove_all_pets_cubit.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  final RemoveAllPetsCubit removeAllPetsCubit =
      homeInjector<RemoveAllPetsCubit>();

  String _version = "";

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  void _loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              right: 20,
              child: Text("Version $_version"),
            ),
            ListView(
              padding: const EdgeInsets.only(top: 30),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/petzania_logo.png"),
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "PetZania",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColor.defaultColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: Divider(color: AppColor.defaultColor, thickness: 1),
                ),
                BlocBuilder<GetPetListCubit, List<PetEntity>>(
                  builder: (context, petList) {
                    return ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: petList.isNotEmpty ? Colors.red : Colors.grey,
                      ),
                      title: Text(
                        'Remove All Pets (${context.read<GetPetListCubit>().state.length})',
                        style: TextStyle(
                          color: petList.isNotEmpty ? Colors.red : Colors.grey,
                        ),
                      ),
                      onTap: petList.isNotEmpty
                          ? () {
                              DialogService.showDeleteCancel(
                                context: context,
                                onDelete: () async {
                                  await removeAllPetsCubit.removeAllPets();
                                },
                              );
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
