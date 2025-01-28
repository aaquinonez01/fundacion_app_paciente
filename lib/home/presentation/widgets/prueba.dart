import 'package:flutter/material.dart';

class CustomInputList extends StatefulWidget {
  final String label;
  final String hint;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;
  final String? errorMessage;

  const CustomInputList({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.errorMessage,
  });

  @override
  _CustomInputListState createState() => _CustomInputListState();
}

class _CustomInputListState extends State<CustomInputList> {
  final TextEditingController _controller = TextEditingController();

  // Método para agregar un item a la lista
  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Creamos una copia de la lista y añadimos el nuevo item
        final updatedItems = List<String>.from(widget.items);
        updatedItems.add(_controller.text.trim());
        widget.onChanged(updatedItems); // Actualizamos el estado
        _controller.clear();
      });
    }
  }

  // Método para eliminar un item de la lista
  void _removeItem(String item) {
    setState(() {
      // Creamos una copia de la lista y eliminamos el item
      final updatedItems = List<String>.from(widget.items);
      updatedItems.remove(item);
      widget.onChanged(updatedItems); // Actualizamos el estado
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.errorMessage != null ? Colors.red : colors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: widget.items.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () => _removeItem(item),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 15, color: Colors.black54),
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: _addItem,
            ),
            errorText: widget.errorMessage,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          onSubmitted: (_) => _addItem(),
        ),
      ],
    );
  }
}
