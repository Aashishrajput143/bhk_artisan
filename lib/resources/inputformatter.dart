import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class PriceFormatter {
  static String formatPrice(price) {
    if (price == null) {
      return "0";
    } else {
      final NumberFormat formatter = NumberFormat("#,##,##0");
      return formatter.format(price);
    }
  }
}

class MaxAmountInputFormatter extends TextInputFormatter {
  final double maxAmount;

  MaxAmountInputFormatter(this.maxAmount);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    double? newAmount = double.tryParse(newValue.text);

    if (newAmount == null || newAmount > maxAmount) {
      return oldValue;
    }

    return newValue;
  }
}

class NoSpaceTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');

    int cursorPosition = newValue.selection.baseOffset -
        (newValue.text.length - newText.length);

    cursorPosition = cursorPosition.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

class AadhaarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\s+'), ''); // remove existing spaces
    String newText = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      newText += digitsOnly[i];
      if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
        newText += ' '; // add space after every 4 digits
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

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
      return oldValue;
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
      return newValue;
    }
    return oldValue;
  }
}

class RemoveTrailingPeriodsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    bool isBackspace = newValue.text.length < oldValue.text.length;

    if (isBackspace) {
      return newValue;
    }

    String newText = newValue.text
        .split('\n') // Split text by lines
        .map((line) => line.replaceAll(RegExp(r' {2,}'), ' ')) // Replace multiple spaces with one
        .join('\n'); // Join lines back with newline

    // Remove trailing periods from words
    newText = newText.replaceAllMapped(RegExp(r'(\w+)'), (match) {
      return match.group(1) ?? '';
    });

    int baseOffset = newValue.selection.baseOffset;
    int extentOffset = newValue.selection.extentOffset;

    baseOffset = baseOffset > newText.length ? newText.length : baseOffset;
    extentOffset = extentOffset > newText.length ? newText.length : extentOffset;

    return TextEditingValue(
      text: newText,
      selection: TextSelection(
        baseOffset: baseOffset,
        extentOffset: extentOffset,
      ),
    );
  }
}


class RangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < 0 || value > 100) {
      return oldValue;
    }

    return newValue;
  }
}

class EmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
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
    return oldValue;
  }
}

class NoDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String filteredText = newValue.text.replaceAll(RegExp(r'\d'), '');
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}