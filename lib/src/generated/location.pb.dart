// This is a generated file - do not edit.
//
// Generated from location.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'location.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'location.pbenum.dart';

/// Get the latitude and longitude for a given location
/// Commented parameters in the message definition are not implemeneted yet
/// location_type {LocationType} - name or value of the desired LocationType enum
/// location {OneOfLocation} - city name, zip code, or coordinates
class RequestLocation extends $pb.GeneratedMessage {
  factory RequestLocation({
    LocationType? locationType,
    OneOfLocation? location,
  }) {
    final result = create();
    if (locationType != null) result.locationType = locationType;
    if (location != null) result.location = location;
    return result;
  }

  RequestLocation._();

  factory RequestLocation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestLocation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestLocation', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..e<LocationType>(1, _omitFieldNames ? '' : 'locationType', $pb.PbFieldType.OE, defaultOrMaker: LocationType.LOCATION_TYPE_UNSPECIFIED, valueOf: LocationType.valueOf, enumValues: LocationType.values)
    ..aOM<OneOfLocation>(2, _omitFieldNames ? '' : 'location', subBuilder: OneOfLocation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestLocation clone() => RequestLocation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestLocation copyWith(void Function(RequestLocation) updates) => super.copyWith((message) => updates(message as RequestLocation)) as RequestLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestLocation create() => RequestLocation._();
  @$core.override
  RequestLocation createEmptyInstance() => create();
  static $pb.PbList<RequestLocation> createRepeated() => $pb.PbList<RequestLocation>();
  @$core.pragma('dart2js:noInline')
  static RequestLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestLocation>(create);
  static RequestLocation? _defaultInstance;

  @$pb.TagNumber(1)
  LocationType get locationType => $_getN(0);
  @$pb.TagNumber(1)
  set locationType(LocationType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocationType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocationType() => $_clearField(1);

  @$pb.TagNumber(2)
  OneOfLocation get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(OneOfLocation value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => $_clearField(2);
  @$pb.TagNumber(2)
  OneOfLocation ensureLocation() => $_ensure(1);
}

/// Response to RequestLocation
class SendLocation extends $pb.GeneratedMessage {
  factory SendLocation({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    return result;
  }

  SendLocation._();

  factory SendLocation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SendLocation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendLocation', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendLocation clone() => SendLocation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendLocation copyWith(void Function(SendLocation) updates) => super.copyWith((message) => updates(message as SendLocation)) as SendLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendLocation create() => SendLocation._();
  @$core.override
  SendLocation createEmptyInstance() => create();
  static $pb.PbList<SendLocation> createRepeated() => $pb.PbList<SendLocation>();
  @$core.pragma('dart2js:noInline')
  static SendLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendLocation>(create);
  static SendLocation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);
}

/// Sub-message for OneOfLocation
/// Used to specify actual coordinates for the desired location
class Coordinates extends $pb.GeneratedMessage {
  factory Coordinates({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    return result;
  }

  Coordinates._();

  factory Coordinates.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Coordinates.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Coordinates', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Coordinates clone() => Coordinates()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Coordinates copyWith(void Function(Coordinates) updates) => super.copyWith((message) => updates(message as Coordinates)) as Coordinates;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Coordinates create() => Coordinates._();
  @$core.override
  Coordinates createEmptyInstance() => create();
  static $pb.PbList<Coordinates> createRepeated() => $pb.PbList<Coordinates>();
  @$core.pragma('dart2js:noInline')
  static Coordinates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Coordinates>(create);
  static Coordinates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);
}

enum OneOfLocation_LocationId {
  city, 
  zipCode, 
  coords, 
  notSet
}

/// Sub-message for RequestLocation, RequestCurrent, and RequestFiveDay
/// Used to specify the desired location: city, zip code, or coordinates.
class OneOfLocation extends $pb.GeneratedMessage {
  factory OneOfLocation({
    $core.String? city,
    $core.String? zipCode,
    Coordinates? coords,
  }) {
    final result = create();
    if (city != null) result.city = city;
    if (zipCode != null) result.zipCode = zipCode;
    if (coords != null) result.coords = coords;
    return result;
  }

  OneOfLocation._();

  factory OneOfLocation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OneOfLocation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, OneOfLocation_LocationId> _OneOfLocation_LocationIdByTag = {
    1 : OneOfLocation_LocationId.city,
    2 : OneOfLocation_LocationId.zipCode,
    3 : OneOfLocation_LocationId.coords,
    0 : OneOfLocation_LocationId.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OneOfLocation', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'city')
    ..aOS(2, _omitFieldNames ? '' : 'zipCode')
    ..aOM<Coordinates>(3, _omitFieldNames ? '' : 'coords', subBuilder: Coordinates.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OneOfLocation clone() => OneOfLocation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OneOfLocation copyWith(void Function(OneOfLocation) updates) => super.copyWith((message) => updates(message as OneOfLocation)) as OneOfLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OneOfLocation create() => OneOfLocation._();
  @$core.override
  OneOfLocation createEmptyInstance() => create();
  static $pb.PbList<OneOfLocation> createRepeated() => $pb.PbList<OneOfLocation>();
  @$core.pragma('dart2js:noInline')
  static OneOfLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OneOfLocation>(create);
  static OneOfLocation? _defaultInstance;

  OneOfLocation_LocationId whichLocationId() => _OneOfLocation_LocationIdByTag[$_whichOneof(0)]!;
  void clearLocationId() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get city => $_getSZ(0);
  @$pb.TagNumber(1)
  set city($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCity() => $_has(0);
  @$pb.TagNumber(1)
  void clearCity() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get zipCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set zipCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasZipCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearZipCode() => $_clearField(2);

  @$pb.TagNumber(3)
  Coordinates get coords => $_getN(2);
  @$pb.TagNumber(3)
  set coords(Coordinates value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCoords() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoords() => $_clearField(3);
  @$pb.TagNumber(3)
  Coordinates ensureCoords() => $_ensure(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
