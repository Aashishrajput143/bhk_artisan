import 'package:flutter/services.dart';

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty && newValue.text.startsWith('0')) {
      return oldValue; // Prevent the first digit from being zero
    }
    return newValue;
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9@._-]*$');

    if (emailRegex.hasMatch(newValue.text)) {
      return newValue; // Allows valid email characters
    }
    return oldValue; // Ignores the invalid character
  }
}

class RemoveTrailingPeriodsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Replace multiple consecutive spaces with a single space
    String newText = newValue.text.replaceAll(RegExp(r'\s+'), ' ');

    // Remove trailing periods after each word
    newText = newText.replaceAllMapped(RegExp(r'(\w+)\.'), (match) {
      return match.group(1) ?? '';
    });

    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}

class RangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Ensure input is a valid number
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < 0 || value > 100) {
      return oldValue; // If the value is not valid, keep the old value
    }

    return newValue; // Otherwise, allow the input
  }
}

class EmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression to match any emoji character
    final RegExp emojiRegex = RegExp(
        r'[\u{1F600}-\u{1F64F}]|' // Emoticons
        r'[\u{1F300}-\u{1F5FF}]|' // Miscellaneous Symbols and Pictographs
        r'[\u{1F680}-\u{1F6FF}]|' // Transport and Map Symbols
        r'[\u{1F700}-\u{1F77F}]|' // Alchemical Symbols
        r'[\u{1F780}-\u{1F7FF}]|' // Geometric Shapes Extended
        r'[\u{1F800}-\u{1F8FF}]|' // Supplemental Arrows-C
        r'[\u{1F900}-\u{1F9FF}]|' // Supplemental Symbols and Pictographs
        r'[\u{1FA00}-\u{1FA6F}]|' // Chess Symbols
        r'[\u{1FA70}-\u{1FAFF}]|' // Symbols and Pictographs Extended-A
        r'[\u{2600}-\u{26FF}]|' // Miscellaneous Symbols
        r'[\u{2700}-\u{27BF}]' // Dingbats
        ,
        unicode: true);

    // Remove any emoji characters from the new text
    String filteredText = newValue.text.replaceAll(emojiRegex, '');

    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}

class SpecialCharacterValidator extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp allowedPattern = RegExp(r'^[a-zA-Z0-9 ]*$');
    if (allowedPattern.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue; // Reject changes with special characters
  }
}

class NoDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Use regular expression to remove any digits
    String filteredText = newValue.text.replaceAll(RegExp(r'\d'), '');
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
