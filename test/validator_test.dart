import 'package:flutter_test/flutter_test.dart';
import 'package:study/utils/validator.dart';

void main() {
  group("Testing strong password", () {
    test(
        "password must have 1 number, 1 character, 1 special symbol and min 5 length",
        () {
      expect(isStrongPassword("test@123") == null, true);
    });

    test("Checking has min length", () {
      expect(isStrongPassword("t@1") != null, true);
    });
    test("Checking has atleast 1 character", () {
      expect(isStrongPassword("t1111") != null, true);
    });
    test("Checking has atleast 1 number", () {
      expect(isStrongPassword("test@") != null, true);
    });
    test("Checking has atleast 1 special character", () {
      expect(isStrongPassword("test@") != null, true);
    });
  });

  group("Testing alpha numeric", () {
    test("must have 1 character or 1 number", () {
      expect(isAlphanumeric("t1") == null, true);
    });

    test("must nut have extra character", () {
      expect(isAlphanumeric("t1@") != null, true);
    });
  });
}
