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

/// Enum to specify the location type for which data is needed.
/// Helps the API find info for the correct location. If unspecified, an
/// attept is still made. However, results may be inaccurate if city is used,
/// or fail entirely if zip code or coordinates are used.
class LocationType extends $pb.ProtobufEnum {
  static const LocationType LOCATION_TYPE_UNSPECIFIED = LocationType._(0, _omitEnumNames ? '' : 'LOCATION_TYPE_UNSPECIFIED');
  static const LocationType LOCATION_TYPE_CITY = LocationType._(1, _omitEnumNames ? '' : 'LOCATION_TYPE_CITY');
  static const LocationType LOCATION_TYPE_ZIP_CODE = LocationType._(2, _omitEnumNames ? '' : 'LOCATION_TYPE_ZIP_CODE');
  static const LocationType LOCATION_TYPE_COORDS = LocationType._(3, _omitEnumNames ? '' : 'LOCATION_TYPE_COORDS');

  static const $core.List<LocationType> values = <LocationType> [
    LOCATION_TYPE_UNSPECIFIED,
    LOCATION_TYPE_CITY,
    LOCATION_TYPE_ZIP_CODE,
    LOCATION_TYPE_COORDS,
  ];

  static final $core.List<LocationType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static LocationType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LocationType._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
