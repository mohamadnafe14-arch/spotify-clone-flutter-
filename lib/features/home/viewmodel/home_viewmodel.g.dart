// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSongsHash() => r'59c940156dc28713db1a2744ed36c0cb5c30b770';

/// See also [getSongs].
@ProviderFor(getSongs)
final getSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getSongs,
  name: r'getSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);
// ignore: deprecated_member_use
typedef GetSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewmodelHash() => r'0008cb180fa8ac9ce50e004b7f3b8270939c6ad6';

/// See also [HomeViewmodel].
@ProviderFor(HomeViewmodel)
final homeViewmodelProvider =
    AutoDisposeNotifierProvider<HomeViewmodel, AsyncValue?>.internal(
  HomeViewmodel.new,
  name: r'homeViewmodelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewmodelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewmodel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
