import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/features/home/domain/usecases/delete_pet_usecase.dart';
import 'package:petzania/src/features/home/presentation/bloc/home_bloc.dart';

class DeletePetCubit extends Cubit<void> {
  final DeletePetUseCase deletePetUseCase;
  final HomeBloc homeBloc;

  DeletePetCubit({
    required this.deletePetUseCase,
    required this.homeBloc,
  }) : super(null);

  Future<void> deletePet(int index) async {
    await deletePetUseCase(DeletePetParams(index: index));
    homeBloc.add(GetPetListEvent());
  }
}
