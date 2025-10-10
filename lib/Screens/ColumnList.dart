import 'package:flutter/material.dart';

class ColumnScreen extends StatefulWidget {
  const ColumnScreen({super.key});

  @override
  State<ColumnScreen> createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  final List<String> _items = [];
  final TextEditingController _textController = TextEditingController();

  void _addItem() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(text);
        _textController.clear();
      });
    }
  }

  void _removeItem() {
    if (_items.isNotEmpty) {
      setState(() {
        _items.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _items.map((item) => Text(item)).toList(),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Введите пункт покупки',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                tooltip: 'Добавить',
              ),
              IconButton(
                onPressed: _removeItem,
                icon: const Icon(Icons.remove),
                tooltip: 'Удалить последний пункт',
              ),
            ],
          ),
        ],
      ),
    );
  }
}