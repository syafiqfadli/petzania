import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/core/widgets/base.dart';
import 'package:petzania/src/features/add_pet/presentation/pages/add_pet_page.dart';
import 'package:petzania/src/features/home/home_injector.dart';
import 'package:petzania/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:petzania/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
import 'package:petzania/src/features/home/presentation/cubit/is_selected_cubit.dart';
import 'package:petzania/src/features/home/presentation/cubit/refresh_home_cubit.dart';
import 'package:petzania/src/features/home/presentation/widgets/has_pet.dart';
import 'package:petzania/src/features/home/presentation/widgets/no_pet.dart';
import 'package:petzania/src/features/home/presentation/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  final GetPetListCubit getPetListCubit = homeInjector<GetPetListCubit>();
  final RefreshHomeCubit refreshHomeCubit = homeInjector<RefreshHomeCubit>();
  final IsSelectedCubit isSelectedCubit = homeInjector<IsSelectedCubit>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const SideBarWidget(),
        body: BaseWithScaffold(
          title: "My Pets",
          prefixIcon: IconButton(
            icon: const Icon((Icons.menu)),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 34,
          ),
          suffixIcon: BlocBuilder<IsSelectedCubit, bool>(
            builder: (context, isSelected) {
              if (!isSelected) {
                return IconButton(
                  icon: const Icon((Icons.add)),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPetPage(),
                      ),
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iconSize: 34,
                );
              }

              return const SizedBox.shrink();
            },
          ),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeHasPet) {
                return const HasPet();
              }

              return const NoPet();
            },
          ),
        ),
      ),
    );
  }
}
