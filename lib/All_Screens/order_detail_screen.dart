import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    final items = orderData['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORDER ID
            Text(
              "Order ID:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(orderData['orderId'] ?? ""),

            const SizedBox(height: 10),

            // STATUS
            Row(
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  orderData['status'] ?? "pending",
                  style: TextStyle(
                    fontSize: 16,
                    color: orderData['status'] == "confirmed"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              "Items:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ITEMS LIST
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        item['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['name']),
                      subtitle: Text("Qty: ${item['quantity']}"),
                      trailing: Text(
                        "Rs ${item['price'] * item['quantity']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs ${orderData['totalPrice']}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
