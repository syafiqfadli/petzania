import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/features/home/home_injector.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
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
  late GetPetListCubit getPetListCubit = homeInjector<GetPetListCubit>();
  late RefreshHomeCubit refreshHomeCubit = homeInjector<RefreshHomeCubit>();

  @override
  void initState() {
    super.initState();
    homeBloc = homeInjector<HomeBloc>()..add(GetPetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWithScaffold(
      title: "My Pets",
      hasRightIcon: true,
      icon: Icons.menu,
      iconPressed: () {},
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: homeBloc),
          BlocProvider.value(value: getPetListCubit),
          BlocProvider.value(value: refreshHomeCubit),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeHasPet) {
              return const HasPet();
            }

            return const NoPet();
          },
        ),
      ),
    );
  }
}
