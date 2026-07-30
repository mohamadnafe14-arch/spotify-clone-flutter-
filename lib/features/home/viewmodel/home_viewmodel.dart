import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/repos/home_repo.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepo _homeRepo;
  @override
  AsyncValue? build() {
    _homeRepo = ref.watch(homeRepoProvider);
    return null;
  }
}
