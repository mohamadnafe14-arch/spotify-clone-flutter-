// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserModelNotifier)
final userModelProvider = UserModelNotifierProvider._();

final class UserModelNotifierProvider
    extends $NotifierProvider<UserModelNotifier, UserModel?> {
  UserModelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userModelNotifierHash();

  @$internal
  @override
  UserModelNotifier create() => UserModelNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }
}

String _$userModelNotifierHash() => r'c1eb02f99eea64440687a3851ba4afb20d5e8184';

abstract class _$UserModelNotifier extends $Notifier<UserModel?> {
  UserModel? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UserModel?, UserModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserModel?, UserModel?>,
              UserModel?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
