import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/common/utils.dart';

void main() {
  group('getColorFromString', () {
    test('should return different colors for different inputs', () {
      final color1 = getColorFromString('input1');
      final color2 = getColorFromString('input2');
      expect(color1, isNot(equals(color2)));
    });
  });

  group('shortenNumber', () {
    test('should return the number as string if less than 1000', () {
      final result = shortenNumber(500);
      expect(result, '500');
    });

    test('should shorten the number to one decimal place with "k" for thousands', () {
      final result1 = shortenNumber(1500);
      final result2 = shortenNumber(4500);
      expect(result1, '1.5k');
      expect(result2, '4.5k');
    });

    test('should round to nearest whole number for values greater than or equal to 10,000', () {
      final result1 = shortenNumber(10000);
      final result2 = shortenNumber(12800);
      expect(result1, '10k');
      expect(result2, '13k');
    });
  });
}
