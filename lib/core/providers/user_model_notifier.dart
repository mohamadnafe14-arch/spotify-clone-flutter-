import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/auth/model/models/user_model.dart';
part 'user_model_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserModelNotifier extends _$UserModelNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void setUser(UserModel user) => state = user;
}
