import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

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
              isSelected ? AppColors.black : AppColors.lightGray,
          padding: EdgeInsets.symmetric(vertical: isSelected ? 16 * 1.2 : 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.small),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
            fontSize: isSelected ? 14 * 1.2 : 14,
            fontWeight: FontWeights.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
