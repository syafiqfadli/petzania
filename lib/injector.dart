import 'package:petzania/src/features/add_pet/add_pet_injector.dart'
    as add_pet_injector;
import 'package:petzania/src/features/camera/camera_injector.dart'
    as camera_injector;
import 'package:petzania/src/features/home/home_injector.dart' as home_injector;
import 'package:petzania/src/features/pet_details/pet_details_injector.dart'
    as pet_details_injector;

import 'src/core/core_injector.dart' as core_injector;

void init() {
  core_injector.init();
  add_pet_injector.init();
  camera_injector.init();
  home_injector.init();
  pet_details_injector.init();
}
