class StringLimiter {
  /// Limits the input string to 25 words and appends "..." if it exceeds the limit.
  static String limitTo25Words(String input, int words) {
    // Split the string into a list of words.
    List<String> countwords = input.split(' ');

    // Check if the length exceeds 25 words.
    if (countwords.length > words) {
      // Join the first 25 words and append "..."
      return '${countwords.take(words).join(' ')}...';
    }

    // Return the original string if it's 25 words or less.
    return input;
  }

  static String limitCharacters(String input, int character) {
    // Check if the string exceeds 25 characters
    if (input.length > character) {
      // Take the first 25 characters and append "..."
      return '${input.substring(0, character)}...';
    }

    // Return the original string if it's 25 characters or less
    return input;
  }
}
