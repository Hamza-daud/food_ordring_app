import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allItems = [];
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ✅ FETCH DATA FROM FIRESTORE
  void fetchData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Dishes").get();

      final data = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      setState(() {
        allItems = data;
        filteredItems = data; // show all initially
      });
    } catch (e) {
      print("Firestore Error: $e");
    }
  }

  // 🔍 SEARCH FUNCTION
  void searchItem(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredItems = allItems;
      });
      return;
    }

    setState(() {
      filteredItems = allItems.where((item) {
        final name = (item['dishname'] ?? '').toString().toLowerCase();

        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  // ⭐ HIGHLIGHT MATCH TEXT
  TextSpan highlightText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final matchIndex = lowerText.indexOf(lowerQuery);

    if (matchIndex == -1) {
      return TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
      );
    }

    return TextSpan(
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(text: text.substring(0, matchIndex)),
        TextSpan(
          text: text.substring(
            matchIndex,
            matchIndex + query.length,
          ),
          style: const TextStyle(
            backgroundColor: Colors.yellow,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: text.substring(matchIndex + query.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Food"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // 🔍 SEARCH BOX
            TextField(
              controller: searchController,
              onChanged: searchItem,
              decoration: InputDecoration(
                hintText: 'Search food...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColor.lightgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📋 LIST
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text("No Items Found"))
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),

                            // IMAGE
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item['dishimage'] ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) =>
                                    const Icon(Icons.fastfood),
                              ),
                            ),

                            // NAME WITH HIGHLIGHT
                            title: RichText(
                              text: highlightText(
                                (item['dishname'] ?? 'No Name').toString(),
                                searchController.text,
                              ),
                            ),

                            subtitle: Text(
                              "Rs ${item['dishprice'] ?? 0}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
