import 'package:flutter/material.dart';

class ListViewSeparatedScreen extends StatefulWidget {
  const ListViewSeparatedScreen({super.key});

  @override
  State<ListViewSeparatedScreen> createState() => _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
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
            child: ListView.separated(
              itemCount: _items.length,
              itemBuilder: (context, index) => Text(_items[index]),
              separatorBuilder: (context, index) => const Divider(),
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
              const SizedBox(width: 8),
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