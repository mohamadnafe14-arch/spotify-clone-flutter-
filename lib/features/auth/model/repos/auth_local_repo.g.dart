// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_local_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authLocalRepo)
final authLocalRepoProvider = AuthLocalRepoProvider._();

final class AuthLocalRepoProvider
    extends $FunctionalProvider<AuthLocalRepo, AuthLocalRepo, AuthLocalRepo>
    with $Provider<AuthLocalRepo> {
  AuthLocalRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalRepoHash();

  @$internal
  @override
  $ProviderElement<AuthLocalRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthLocalRepo create(Ref ref) {
    return authLocalRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalRepo>(value),
    );
  }
}

String _$authLocalRepoHash() => r'a0146b9823e6033ca8b325216e1033f67314a4b8';
