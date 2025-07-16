// This is a generated file - do not edit.
//
// Generated from weather.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'location.pb.dart' as $0;
import 'weather.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'weather.pbenum.dart';

/// Get the current forecast for a given location
/// location_type {LocationType} - name or value of the desired LocationType enum
/// units {Units} - name or value of the desired Units enum
/// location {OneOfLocation} - city name, zip code, or coordinates
class RequestCurrent extends $pb.GeneratedMessage {
  factory RequestCurrent({
    $0.LocationType? locationType,
    Units? units,
    $0.OneOfLocation? location,
  }) {
    final result = create();
    if (locationType != null) result.locationType = locationType;
    if (units != null) result.units = units;
    if (location != null) result.location = location;
    return result;
  }

  RequestCurrent._();

  factory RequestCurrent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestCurrent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestCurrent', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..e<$0.LocationType>(1, _omitFieldNames ? '' : 'locationType', $pb.PbFieldType.OE, defaultOrMaker: $0.LocationType.LOCATION_TYPE_UNSPECIFIED, valueOf: $0.LocationType.valueOf, enumValues: $0.LocationType.values)
    ..e<Units>(2, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OE, defaultOrMaker: Units.UNITS_UNSPECIFIED, valueOf: Units.valueOf, enumValues: Units.values)
    ..aOM<$0.OneOfLocation>(3, _omitFieldNames ? '' : 'location', subBuilder: $0.OneOfLocation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestCurrent clone() => RequestCurrent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestCurrent copyWith(void Function(RequestCurrent) updates) => super.copyWith((message) => updates(message as RequestCurrent)) as RequestCurrent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestCurrent create() => RequestCurrent._();
  @$core.override
  RequestCurrent createEmptyInstance() => create();
  static $pb.PbList<RequestCurrent> createRepeated() => $pb.PbList<RequestCurrent>();
  @$core.pragma('dart2js:noInline')
  static RequestCurrent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestCurrent>(create);
  static RequestCurrent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.LocationType get locationType => $_getN(0);
  @$pb.TagNumber(1)
  set locationType($0.LocationType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocationType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocationType() => $_clearField(1);

  @$pb.TagNumber(2)
  Units get units => $_getN(1);
  @$pb.TagNumber(2)
  set units(Units value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUnits() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnits() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.OneOfLocation get location => $_getN(2);
  @$pb.TagNumber(3)
  set location($0.OneOfLocation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.OneOfLocation ensureLocation() => $_ensure(2);
}

/// Response to RequestCurrent
class SendCurrent extends $pb.GeneratedMessage {
  factory SendCurrent({
    $core.String? payload,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    return result;
  }

  SendCurrent._();

  factory SendCurrent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SendCurrent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendCurrent', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payload')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCurrent clone() => SendCurrent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCurrent copyWith(void Function(SendCurrent) updates) => super.copyWith((message) => updates(message as SendCurrent)) as SendCurrent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendCurrent create() => SendCurrent._();
  @$core.override
  SendCurrent createEmptyInstance() => create();
  static $pb.PbList<SendCurrent> createRepeated() => $pb.PbList<SendCurrent>();
  @$core.pragma('dart2js:noInline')
  static SendCurrent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCurrent>(create);
  static SendCurrent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payload => $_getSZ(0);
  @$pb.TagNumber(1)
  set payload($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);
}

/// Get the extended forecast for a given location up to 16 days in the future
/// location_type {LocationType} - name or value of the desired LocationType enum
/// units {Units} - name or value of the desired Units enum
/// location {OneOfLocation} - city name, zip code, or coordinates
class RequestFiveDay extends $pb.GeneratedMessage {
  factory RequestFiveDay({
    $0.LocationType? locationType,
    Units? units,
    $0.OneOfLocation? location,
  }) {
    final result = create();
    if (locationType != null) result.locationType = locationType;
    if (units != null) result.units = units;
    if (location != null) result.location = location;
    return result;
  }

  RequestFiveDay._();

  factory RequestFiveDay.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestFiveDay.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestFiveDay', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..e<$0.LocationType>(1, _omitFieldNames ? '' : 'locationType', $pb.PbFieldType.OE, defaultOrMaker: $0.LocationType.LOCATION_TYPE_UNSPECIFIED, valueOf: $0.LocationType.valueOf, enumValues: $0.LocationType.values)
    ..e<Units>(2, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OE, defaultOrMaker: Units.UNITS_UNSPECIFIED, valueOf: Units.valueOf, enumValues: Units.values)
    ..aOM<$0.OneOfLocation>(3, _omitFieldNames ? '' : 'location', subBuilder: $0.OneOfLocation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFiveDay clone() => RequestFiveDay()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestFiveDay copyWith(void Function(RequestFiveDay) updates) => super.copyWith((message) => updates(message as RequestFiveDay)) as RequestFiveDay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestFiveDay create() => RequestFiveDay._();
  @$core.override
  RequestFiveDay createEmptyInstance() => create();
  static $pb.PbList<RequestFiveDay> createRepeated() => $pb.PbList<RequestFiveDay>();
  @$core.pragma('dart2js:noInline')
  static RequestFiveDay getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestFiveDay>(create);
  static RequestFiveDay? _defaultInstance;

  @$pb.TagNumber(1)
  $0.LocationType get locationType => $_getN(0);
  @$pb.TagNumber(1)
  set locationType($0.LocationType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocationType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocationType() => $_clearField(1);

  @$pb.TagNumber(2)
  Units get units => $_getN(1);
  @$pb.TagNumber(2)
  set units(Units value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUnits() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnits() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.OneOfLocation get location => $_getN(2);
  @$pb.TagNumber(3)
  set location($0.OneOfLocation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.OneOfLocation ensureLocation() => $_ensure(2);
}

/// Response to RequestExtended
class SendFiveDay extends $pb.GeneratedMessage {
  factory SendFiveDay({
    $core.String? payload,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    return result;
  }

  SendFiveDay._();

  factory SendFiveDay.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SendFiveDay.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendFiveDay', package: const $pb.PackageName(_omitMessageNames ? '' : 'weather'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payload')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFiveDay clone() => SendFiveDay()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendFiveDay copyWith(void Function(SendFiveDay) updates) => super.copyWith((message) => updates(message as SendFiveDay)) as SendFiveDay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendFiveDay create() => SendFiveDay._();
  @$core.override
  SendFiveDay createEmptyInstance() => create();
  static $pb.PbList<SendFiveDay> createRepeated() => $pb.PbList<SendFiveDay>();
  @$core.pragma('dart2js:noInline')
  static SendFiveDay getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendFiveDay>(create);
  static SendFiveDay? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payload => $_getSZ(0);
  @$pb.TagNumber(1)
  set payload($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
