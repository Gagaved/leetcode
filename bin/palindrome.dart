import 'dart:math';

void main() {
  final lengths = [100, 200, 400, 800, 1600, 3200, 6400];
  final rand = Random();
  final stopwatch = Stopwatch();

  for (final len in lengths) {
    final testStr = generatePalindromeNoise(len, rand);

    stopwatch.reset();
    stopwatch.start();

    Solution().longestPalindrome(testStr);

    stopwatch.stop();

    final timeMs = stopwatch.elapsedMicroseconds / 1000;
    print('Length: $len\tTime: ${timeMs.toStringAsFixed(2)} ms');
  }
}

String generatePalindromeNoise(int totalLength, Random rand) {
  final half = totalLength ~/ 2;
  final middle = generatePalindrome(half);
  final noise = String.fromCharCodes(
    List.generate(totalLength - middle.length, (_) => randCharCode(rand)),
  );
  return noise.substring(0, noise.length ~/ 2) +
      middle +
      noise.substring(noise.length ~/ 2);
}

String generatePalindrome(int len) {
  final half = len ~/ 2;
  final chars = List.generate(half, (i) => randCharCode(Random()));
  final mirror =
      len.isOdd
          ? [...chars, randCharCode(Random()), ...chars.reversed]
          : [...chars, ...chars.reversed];
  return String.fromCharCodes(mirror);
}

int randCharCode(Random rand) => rand.nextInt(26) + 97; // 'a' to 'z'

class Solution {
  String longestPalindrome(String s) {
    if (s.isEmpty) return "";

    final transformed = ['^'];

    for (var char in s.runes) {
      transformed.add('#');
      transformed.add(
        String.fromCharCode(char),
      ); // Преобразование руны в строку
    }
    transformed.add('#');
    transformed.add('\$');

    final P = List.filled(transformed.length, 0);
    int center = 0, right = 0;

    for (int i = 1; i < transformed.length - 1; i++) {
      final mirror = 2 * center - i;

      if (i < right) {
        P[i] = P[mirror].clamp(0, right - i);
      }

      while (transformed[i + P[i] + 1] == transformed[i - P[i] - 1]) {
        P[i]++;
      }

      if (i + P[i] > right) {
        center = i;
        right = i + P[i];
      }
    }

    int maxLen = 0;
    int centerIndex = 0;
    for (int i = 1; i < P.length - 1; i++) {
      if (P[i] > maxLen) {
        maxLen = P[i];
        centerIndex = i;
      }
    }

    final start = (centerIndex - maxLen) ~/ 2;
    return s.substring(start, start + maxLen);
  }
}
