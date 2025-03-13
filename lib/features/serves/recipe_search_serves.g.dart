// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_search_serves.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchRecipesByNameHash() =>
    r'b9e496075a409896aeb2d51e7330e7e6f2dd6204';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchRecipesByName].
@ProviderFor(searchRecipesByName)
const searchRecipesByNameProvider = SearchRecipesByNameFamily();

/// See also [searchRecipesByName].
class SearchRecipesByNameFamily
    extends Family<AsyncValue<List<CompleteRecipe>>> {
  /// See also [searchRecipesByName].
  const SearchRecipesByNameFamily();

  /// See also [searchRecipesByName].
  SearchRecipesByNameProvider call(
    String query,
  ) {
    return SearchRecipesByNameProvider(
      query,
    );
  }

  @override
  SearchRecipesByNameProvider getProviderOverride(
    covariant SearchRecipesByNameProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchRecipesByNameProvider';
}

/// See also [searchRecipesByName].
class SearchRecipesByNameProvider extends FutureProvider<List<CompleteRecipe>> {
  /// See also [searchRecipesByName].
  SearchRecipesByNameProvider(
    String query,
  ) : this._internal(
          (ref) => searchRecipesByName(
            ref as SearchRecipesByNameRef,
            query,
          ),
          from: searchRecipesByNameProvider,
          name: r'searchRecipesByNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchRecipesByNameHash,
          dependencies: SearchRecipesByNameFamily._dependencies,
          allTransitiveDependencies:
              SearchRecipesByNameFamily._allTransitiveDependencies,
          query: query,
        );

  SearchRecipesByNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<CompleteRecipe>> Function(SearchRecipesByNameRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchRecipesByNameProvider._internal(
        (ref) => create(ref as SearchRecipesByNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  FutureProviderElement<List<CompleteRecipe>> createElement() {
    return _SearchRecipesByNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchRecipesByNameProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchRecipesByNameRef on FutureProviderRef<List<CompleteRecipe>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchRecipesByNameProviderElement
    extends FutureProviderElement<List<CompleteRecipe>>
    with SearchRecipesByNameRef {
  _SearchRecipesByNameProviderElement(super.provider);

  @override
  String get query => (origin as SearchRecipesByNameProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
