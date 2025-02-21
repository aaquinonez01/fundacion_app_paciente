import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final bool isDatePicker;
  final String initialValue;
  final bool lastDate;

  const CustomDateFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.isDatePicker = false,
    this.initialValue = '',
    this.lastDate = true,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomDateFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomDateFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

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
      child: TextFormField(
        controller: _controller, // Usar el controlador aquí
        readOnly: widget.isDatePicker,
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
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
          label: widget.label != null
              ? Text(
                  widget.label!,
                  style: TextStyle(
                    color: widget.errorMessage != null
                        ? Colors.red
                        : colors.primary,
                  ),
                )
              : null,
          hintText: widget.hint,
          errorText: widget.errorMessage,
        ),
        onTap: widget.isDatePicker
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: widget.lastDate ? DateTime.now() : DateTime(2101),
                );
                if (pickedDate != null) {
                  final formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  widget.onChanged?.call(
                      formattedDate); // Actualizar el estado con la fecha seleccionada
                }
              }
            : null, // Solo abrir DatePicker si isDatePicker es true
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
