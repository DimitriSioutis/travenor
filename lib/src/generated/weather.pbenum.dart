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

/// Sub-message used by Current & Extended to specify preferred units
/// If unspecified, results will default to standard (temperature in Kelvin)
class Units extends $pb.ProtobufEnum {
  static const Units UNITS_UNSPECIFIED = Units._(0, _omitEnumNames ? '' : 'UNITS_UNSPECIFIED');
  static const Units UNITS_STANDARD = Units._(1, _omitEnumNames ? '' : 'UNITS_STANDARD');
  static const Units UNITS_METRIC = Units._(2, _omitEnumNames ? '' : 'UNITS_METRIC');
  static const Units UNITS_IMPERIAL = Units._(3, _omitEnumNames ? '' : 'UNITS_IMPERIAL');

  static const $core.List<Units> values = <Units> [
    UNITS_UNSPECIFIED,
    UNITS_STANDARD,
    UNITS_METRIC,
    UNITS_IMPERIAL,
  ];

  static final $core.List<Units?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static Units? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Units._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
