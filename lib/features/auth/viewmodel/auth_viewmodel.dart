import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/auth/model/models/user_model.dart';
import 'package:spotify_clone/features/auth/model/repos/auth_repo.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  final AuthRepo _authRepo = AuthRepo();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await _authRepo.login(email: email, password: password);
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();
    final result = await _authRepo.signUp(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}
