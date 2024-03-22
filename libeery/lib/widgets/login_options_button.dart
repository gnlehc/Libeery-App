import 'package:flutter/material.dart';

class LoginOptionsButton extends StatelessWidget {
  final String buttonText;
  final Function(bool) onPressed;
  final bool isSelected;

  const LoginOptionsButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!isSelected) {
            onPressed(true);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? const Color(0xFF333333) : Color(0xFFD9D9D9),
          padding: EdgeInsets.symmetric(vertical: isSelected ? 16 * 1.2 : 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF333333),
            fontSize: isSelected ? 14 * 1.2 : 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
