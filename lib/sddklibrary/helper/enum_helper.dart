extension EnumHelper<T extends Enum> on Enum {
  String toJson() => name;

  static T fromJson<T extends Enum>(Iterable<T> values, String json) {
    return values.firstWhere(
      (e) => e.name == json,
      orElse: () => throw ArgumentError('Invalid enum value: $json, must be one of ${values.map((e) => e.name).toList()}'),
    );
  }
}
