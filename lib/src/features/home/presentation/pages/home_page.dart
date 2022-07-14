import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/features/home/home_injector.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/is_selected_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/refresh_home_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/has_pet.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/no_pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  final GetPetListCubit getPetListCubit = homeInjector<GetPetListCubit>();
  final RefreshHomeCubit refreshHomeCubit = homeInjector<RefreshHomeCubit>();
  final IsSelectedCubit isSelectedCubit = homeInjector<IsSelectedCubit>();

  @override
  void initState() {
    super.initState();
    homeBloc = homeInjector<HomeBloc>()..add(GetPetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: homeBloc),
        BlocProvider.value(value: getPetListCubit),
        BlocProvider.value(value: refreshHomeCubit),
        BlocProvider.value(value: isSelectedCubit),
      ],
      child: BlocBuilder<IsSelectedCubit, bool>(
        builder: (context, isSelected) {
          return BaseWithScaffold(
            title: "My Pets",
            hasRightIcon: !isSelected,
            icon: Icons.menu,
            iconPressed: () {},
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeHasPet) {
                  return const HasPet();
                }

                return const NoPet();
              },
            ),
          );
        },
      ),
    );
  }
}
