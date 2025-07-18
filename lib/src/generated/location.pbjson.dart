// This is a generated file - do not edit.
//
// Generated from location.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use locationTypeDescriptor instead')
const LocationType$json = {
  '1': 'LocationType',
  '2': [
    {'1': 'LOCATION_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'LOCATION_TYPE_CITY', '2': 1},
    {'1': 'LOCATION_TYPE_ZIP_CODE', '2': 2},
    {'1': 'LOCATION_TYPE_COORDS', '2': 3},
  ],
};

/// Descriptor for `LocationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List locationTypeDescriptor = $convert.base64Decode(
    'CgxMb2NhdGlvblR5cGUSHQoZTE9DQVRJT05fVFlQRV9VTlNQRUNJRklFRBAAEhYKEkxPQ0FUSU'
    '9OX1RZUEVfQ0lUWRABEhoKFkxPQ0FUSU9OX1RZUEVfWklQX0NPREUQAhIYChRMT0NBVElPTl9U'
    'WVBFX0NPT1JEUxAD');

@$core.Deprecated('Use requestLocationDescriptor instead')
const RequestLocation$json = {
  '1': 'RequestLocation',
  '2': [
    {'1': 'location_type', '3': 1, '4': 1, '5': 14, '6': '.weather.LocationType', '10': 'locationType'},
    {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.weather.OneOfLocation', '10': 'location'},
  ],
};

/// Descriptor for `RequestLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestLocationDescriptor = $convert.base64Decode(
    'Cg9SZXF1ZXN0TG9jYXRpb24SOgoNbG9jYXRpb25fdHlwZRgBIAEoDjIVLndlYXRoZXIuTG9jYX'
    'Rpb25UeXBlUgxsb2NhdGlvblR5cGUSMgoIbG9jYXRpb24YAiABKAsyFi53ZWF0aGVyLk9uZU9m'
    'TG9jYXRpb25SCGxvY2F0aW9u');

@$core.Deprecated('Use sendLocationDescriptor instead')
const SendLocation$json = {
  '1': 'SendLocation',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 2, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 2, '10': 'longitude'},
  ],
};

/// Descriptor for `SendLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendLocationDescriptor = $convert.base64Decode(
    'CgxTZW5kTG9jYXRpb24SGgoIbGF0aXR1ZGUYASABKAJSCGxhdGl0dWRlEhwKCWxvbmdpdHVkZR'
    'gCIAEoAlIJbG9uZ2l0dWRl');

@$core.Deprecated('Use coordinatesDescriptor instead')
const Coordinates$json = {
  '1': 'Coordinates',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 2, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 2, '10': 'longitude'},
  ],
};

/// Descriptor for `Coordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coordinatesDescriptor = $convert.base64Decode(
    'CgtDb29yZGluYXRlcxIaCghsYXRpdHVkZRgBIAEoAlIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGA'
    'IgASgCUglsb25naXR1ZGU=');

@$core.Deprecated('Use oneOfLocationDescriptor instead')
const OneOfLocation$json = {
  '1': 'OneOfLocation',
  '2': [
    {'1': 'city', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'city'},
    {'1': 'zip_code', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'zipCode'},
    {'1': 'coords', '3': 3, '4': 1, '5': 11, '6': '.weather.Coordinates', '9': 0, '10': 'coords'},
  ],
  '8': [
    {'1': 'location_id'},
  ],
};

/// Descriptor for `OneOfLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oneOfLocationDescriptor = $convert.base64Decode(
    'Cg1PbmVPZkxvY2F0aW9uEhQKBGNpdHkYASABKAlIAFIEY2l0eRIbCgh6aXBfY29kZRgCIAEoCU'
    'gAUgd6aXBDb2RlEi4KBmNvb3JkcxgDIAEoCzIULndlYXRoZXIuQ29vcmRpbmF0ZXNIAFIGY29v'
    'cmRzQg0KC2xvY2F0aW9uX2lk');

