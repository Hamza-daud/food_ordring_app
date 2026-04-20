import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  late DocumentReference chatRef;

  @override
  void initState() {
    super.initState();

    chatRef = FirebaseFirestore.instance.collection("chats").doc(uid);

    chatRef.set({
      "userId": uid,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void sendMessage() async {
    if (msgController.text.trim().isEmpty) return;

    await chatRef.collection("messages").add({
      "text": msgController.text,
      "senderId": uid,
      "timestamp": FieldValue.serverTimestamp(),
    });

    msgController.clear();

    // 🔥 auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Admin"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ================= CHAT LIST =================
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatRef
                  .collection("messages")
                  .orderBy("timestamp", descending: false) // 🔥 FIX
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index];

                    bool isMe = data["senderId"] == uid;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.green : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          data["text"],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // ================= INPUT =================
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
