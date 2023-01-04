import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/services/dialog_service.dart';
import 'package:petzania/src/core/util/colors.dart';
import 'package:petzania/src/features/home/home_injector.dart';
import 'package:petzania/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
import 'package:petzania/src/features/home/presentation/cubit/remove_all_pets_cubit.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  late GetPetListCubit getPetListCubit;
  final RemoveAllPetsCubit removeAllPetsCubit =
      homeInjector<RemoveAllPetsCubit>();

  String _version = "";

  @override
  void initState() {
    super.initState();
    getPetListCubit = homeInjector<GetPetListCubit>()..getPetList();
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
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
                        'Remove All Pets',
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
