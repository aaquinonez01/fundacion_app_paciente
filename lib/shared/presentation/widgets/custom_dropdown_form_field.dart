import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final Icon? prefixIcon;
  final String? errorMessage;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const CustomDropdownFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.value,
    this.items,
    this.prefixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
            topLeft: borderRadius,
            bottomLeft: borderRadius,
            bottomRight: borderRadius),
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          prefix: prefixIcon,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(40)),
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder:
              border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          label: label != null
              ? Text(
                  label!,
                  style: TextStyle(
                    color: errorMessage != null ? Colors.red : colors.primary,
                  ),
                )
              : null,
          hintText: hint,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
