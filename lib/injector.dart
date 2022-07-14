import 'package:pet_care_flutter_app/src/core/core_injector.dart'
    as core_injector;
import 'package:pet_care_flutter_app/src/features/add_pet/add_pet_injector.dart'
    as add_pet_injector;
import 'package:pet_care_flutter_app/src/features/camera/camera_injector.dart'
    as camera_injector;
import 'package:pet_care_flutter_app/src/features/home/home_injector.dart'
    as home_injector;

void init() {
  core_injector.init();
  add_pet_injector.init();
  camera_injector.init();
  home_injector.init();
}
