import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/pages/add_pet_page.dart';
import '../../../../core/widgets/base.dart';
import '../../home_injector.dart';
import '../bloc/home_bloc.dart';
import '../cubit/get_pet_list_cubit.dart';
import '../cubit/is_selected_cubit.dart';
import '../cubit/refresh_home_cubit.dart';
import '../widgets/has_pet.dart';
import '../widgets/no_pet.dart';

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
            leftIcon: IconButton(
              icon: const Icon((Icons.menu)),
              onPressed: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 34,
            ),
            rightIcon: IconButton(
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
            ),
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
