// This is a generated file - do not edit.
//
// Generated from weather.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use unitsDescriptor instead')
const Units$json = {
  '1': 'Units',
  '2': [
    {'1': 'UNITS_UNSPECIFIED', '2': 0},
    {'1': 'UNITS_STANDARD', '2': 1},
    {'1': 'UNITS_METRIC', '2': 2},
    {'1': 'UNITS_IMPERIAL', '2': 3},
  ],
};

/// Descriptor for `Units`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List unitsDescriptor = $convert.base64Decode(
    'CgVVbml0cxIVChFVTklUU19VTlNQRUNJRklFRBAAEhIKDlVOSVRTX1NUQU5EQVJEEAESEAoMVU'
    '5JVFNfTUVUUklDEAISEgoOVU5JVFNfSU1QRVJJQUwQAw==');

@$core.Deprecated('Use requestCurrentDescriptor instead')
const RequestCurrent$json = {
  '1': 'RequestCurrent',
  '2': [
    {'1': 'location_type', '3': 1, '4': 1, '5': 14, '6': '.weather.LocationType', '10': 'locationType'},
    {'1': 'units', '3': 2, '4': 1, '5': 14, '6': '.weather.Units', '10': 'units'},
    {'1': 'location', '3': 3, '4': 1, '5': 11, '6': '.weather.OneOfLocation', '10': 'location'},
  ],
};

/// Descriptor for `RequestCurrent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestCurrentDescriptor = $convert.base64Decode(
    'Cg5SZXF1ZXN0Q3VycmVudBI6Cg1sb2NhdGlvbl90eXBlGAEgASgOMhUud2VhdGhlci5Mb2NhdG'
    'lvblR5cGVSDGxvY2F0aW9uVHlwZRIkCgV1bml0cxgCIAEoDjIOLndlYXRoZXIuVW5pdHNSBXVu'
    'aXRzEjIKCGxvY2F0aW9uGAMgASgLMhYud2VhdGhlci5PbmVPZkxvY2F0aW9uUghsb2NhdGlvbg'
    '==');

@$core.Deprecated('Use sendCurrentDescriptor instead')
const SendCurrent$json = {
  '1': 'SendCurrent',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 9, '10': 'payload'},
  ],
};

/// Descriptor for `SendCurrent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCurrentDescriptor = $convert.base64Decode(
    'CgtTZW5kQ3VycmVudBIYCgdwYXlsb2FkGAEgASgJUgdwYXlsb2Fk');

@$core.Deprecated('Use requestFiveDayDescriptor instead')
const RequestFiveDay$json = {
  '1': 'RequestFiveDay',
  '2': [
    {'1': 'location_type', '3': 1, '4': 1, '5': 14, '6': '.weather.LocationType', '10': 'locationType'},
    {'1': 'units', '3': 2, '4': 1, '5': 14, '6': '.weather.Units', '10': 'units'},
    {'1': 'location', '3': 3, '4': 1, '5': 11, '6': '.weather.OneOfLocation', '10': 'location'},
  ],
};

/// Descriptor for `RequestFiveDay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestFiveDayDescriptor = $convert.base64Decode(
    'Cg5SZXF1ZXN0Rml2ZURheRI6Cg1sb2NhdGlvbl90eXBlGAEgASgOMhUud2VhdGhlci5Mb2NhdG'
    'lvblR5cGVSDGxvY2F0aW9uVHlwZRIkCgV1bml0cxgCIAEoDjIOLndlYXRoZXIuVW5pdHNSBXVu'
    'aXRzEjIKCGxvY2F0aW9uGAMgASgLMhYud2VhdGhlci5PbmVPZkxvY2F0aW9uUghsb2NhdGlvbg'
    '==');

@$core.Deprecated('Use sendFiveDayDescriptor instead')
const SendFiveDay$json = {
  '1': 'SendFiveDay',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 9, '10': 'payload'},
  ],
};

/// Descriptor for `SendFiveDay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFiveDayDescriptor = $convert.base64Decode(
    'CgtTZW5kRml2ZURheRIYCgdwYXlsb2FkGAEgASgJUgdwYXlsb2Fk');

