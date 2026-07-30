// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRepo)
final homeRepoProvider = HomeRepoProvider._();

final class HomeRepoProvider
    extends $FunctionalProvider<HomeRepo, HomeRepo, HomeRepo>
    with $Provider<HomeRepo> {
  HomeRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepoHash();

  @$internal
  @override
  $ProviderElement<HomeRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepo create(Ref ref) {
    return homeRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepo>(value),
    );
  }
}

String _$homeRepoHash() => r'c11a071dc29d6d307f3be5b722228291dc87017f';
