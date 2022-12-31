import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_pet_state.dart';

class UpdatePetCubit extends Cubit<UpdatePetState> {
  UpdatePetCubit() : super(UpdatePetInitial());
}
