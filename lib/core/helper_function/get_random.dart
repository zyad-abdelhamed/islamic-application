import 'dart:math';

int getRandomNumber(int maxNumber) {
  final Random random = Random();
  return random.nextInt(maxNumber);
}
