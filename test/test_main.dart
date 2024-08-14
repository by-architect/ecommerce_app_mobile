import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test anything", () {
    print(Colors.yellow.red);
    print(Color(Colors.yellow.value).red);
    expect(Colors.yellow.value.toString(), Colors.yellow.value.toString());
  });
}
