import 'dart:math';

class GenerateRandomNumber
{
  final List<int> _usedNumbers = []; // List to store used numbers
  final Random _random = Random();

  int generateUniqueRandomNumber(int min, int max) {
    int num;
    do {
      num = min + _random.nextInt(max - min + 1); // Generate random number
    } while (_usedNumbers.contains(num)); // Check if it's already used
    _usedNumbers.add(num); // Add the new number to the list of used numbers
    return num;
  }
}