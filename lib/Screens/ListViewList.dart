import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: _items.map((item) =>
                  ListTile(
                    title: Text(item),
                  )).toList(),
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
                  onSubmitted: (_) => _addItem(),
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
                tooltip: 'Удалить пункт',
              ),
            ],
          ),
        ],
      ),
    );
  }
}