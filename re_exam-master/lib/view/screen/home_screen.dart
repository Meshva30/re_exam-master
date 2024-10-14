import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/shopping_controller.dart';
import '../../controller/sigup_controller.dart';
import '../../model/home_model.dart';

class HomeScreen extends StatelessWidget {
  final ShoppingController shoppingController = Get.put(ShoppingController());
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff005667),
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text('Shopping List',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sync,
              color: Colors.white,
            ),
            onPressed: () {
              shoppingController.Firebase();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (shoppingController.items.isEmpty) {
          return const Center(child: Text('No items in your shopping list.'));
        }

        return ListView.builder(
          itemCount: shoppingController.items.length,
          itemBuilder: (context, index) {
            final item = shoppingController.items[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity: ${item.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Category: ${item.category}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        activeColor: const Color(0xff005667),
                        value: item.purchased,
                        onChanged: (value) {
                          shoppingController.Purchased(item.id!, value!);
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          shoppingController.deleteItem(item.id!);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showEditItemDialog(
                              context, item); // Open edit dialog
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff005667),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showAddItemDialog(context);
        },
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    String name = '';
    int quantity = 1;
    String category = 'Groceries';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => name = value,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              onChanged: (value) => quantity = int.tryParse(value) ?? 1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            DropdownButton<String>(
              value: category,
              onChanged: (value) => category = value!,
              items: ['Groceries', 'Electronics', 'Clothing'].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name.isNotEmpty) {
                shoppingController.addItem(name, quantity, category);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditItemDialog(BuildContext context, ShoppingItem item) {
    String name = item.name;
    int quantity = item.quantity;
    String category = item.category;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => name = value,
              controller: TextEditingController(text: name),
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              onChanged: (value) => quantity = int.tryParse(value) ?? quantity,
              controller: TextEditingController(text: quantity.toString()),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            DropdownButton<String>(
              value: category,
              onChanged: (value) => category = value!,
              items: ['Groceries', 'Electronics', 'Clothing'].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name.isNotEmpty) {
                final updatedItem = ShoppingItem(
                  id: item.id,
                  name: name,
                  quantity: quantity,
                  category: category,
                  purchased: item.purchased,
                );
                shoppingController.editItem(updatedItem);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
