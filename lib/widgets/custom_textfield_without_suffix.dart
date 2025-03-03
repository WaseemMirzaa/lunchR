import 'package:flutter/material.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';

class SimpleTextFieldWithOutSuffixWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;// Optional onChanged callback

  const SimpleTextFieldWithOutSuffixWidget({
    super.key,
    required this.hintText,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.controller,
    this.onChanged,
    this.validator,// Optional onChanged callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 30, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(validator: validator,
              controller: controller,
              style: AppTextStyles.MetropolisRegular.copyWith(
                color: const Color(0xFF4A4B4D),
                fontSize: 16,
              ),
              keyboardType: keyboardType,
              readOnly: isReadOnly,
              onTap: onTap,
              onChanged: onChanged, // Trigger the onChanged callback
              decoration: InputDecoration(
                labelText: isReadOnly ? null : hintText,
                hintText: isReadOnly ? hintText : null,
                hintStyle: AppTextStyles.MetropolisRegular.copyWith(
                  color: const Color(0xFFB6B7B7),
                  fontSize: 12,
                ),
                labelStyle: AppTextStyles.MetropolisRegular.copyWith(
                  color: const Color(0xFFB6B7B7),
                  fontSize: 12,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
