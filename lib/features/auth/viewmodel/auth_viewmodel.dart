import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/providers/user_model_notifier.dart';
import 'package:spotify_clone/features/auth/model/models/user_model.dart';
import 'package:spotify_clone/features/auth/model/repos/auth_local_repo.dart';
import 'package:spotify_clone/features/auth/model/repos/auth_remote_repo.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepo _authRemoteRepo;
  late AuthLocalRepo _authLocalRepo;
  late UserModelNotifier _userModelProvider;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRepoProvider);
    _authLocalRepo = ref.watch(authLocalRepoProvider);
    _userModelProvider = ref.watch(userModelNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPrefs() async => await _authLocalRepo.init();
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await _authRemoteRepo.login(
      email: email,
      password: password,
    );
    result.fold((l) => state = AsyncError(l.message, StackTrace.current), (r) {
      _successRegisterOrLogin(r);
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();
    final result = await _authRemoteRepo.signUp(
      email: email,
      password: password,
      name: name,
    );
    result.fold((l) => state = AsyncError(l.message, StackTrace.current), (r) {
      _successRegisterOrLogin(r);
    });
  }

  Future<UserModel?> getCurrentUser() async {
    final token = await _authLocalRepo.getToken();
    if (token != null) {
      final result = await _authRemoteRepo.getCurrentUser(token: token);
      result.fold(
        (l) {
          return null;
        },
        (r) {
          _userModelProvider.setUser(r);
          return r;
        },
      );
    } else {
      return null;
    }
    return null;
  }

  void _successRegisterOrLogin(UserModel r) {
    _authLocalRepo.saveToken(r.token);
    _userModelProvider.setUser(r);
    state = AsyncData(r);
  }
}
