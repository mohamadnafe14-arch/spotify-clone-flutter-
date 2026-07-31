// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSongs)
final getSongsProvider = GetSongsProvider._();

final class GetSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SongModel>>,
          List<SongModel>,
          FutureOr<List<SongModel>>
        >
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  GetSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getSongs(ref);
  }
}

String _$getSongsHash() => r'392c549c3d2590a7b9e37a911450f53b5db5d79c';

@ProviderFor(HomeViewmodel)
final homeViewmodelProvider = HomeViewmodelProvider._();

final class HomeViewmodelProvider
    extends $NotifierProvider<HomeViewmodel, AsyncValue<dynamic>?> {
  HomeViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewmodelHash();

  @$internal
  @override
  HomeViewmodel create() => HomeViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<dynamic>?>(value),
    );
  }
}

String _$homeViewmodelHash() => r'8cb1e124501bcfe24ece5f2c31fe92415cb2d455';

abstract class _$HomeViewmodel extends $Notifier<AsyncValue<dynamic>?> {
  AsyncValue<dynamic>? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<dynamic>?, AsyncValue<dynamic>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>?, AsyncValue<dynamic>?>,
              AsyncValue<dynamic>?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
