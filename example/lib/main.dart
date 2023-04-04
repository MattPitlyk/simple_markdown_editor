import 'package:flutter/material.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const EditorScreen()));
          },
          color: Colors.blue,
          child: const Text(
            "Editor Screen",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// HomeScreen Editor
class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Editor"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SecondScreen(
                    data: _controller.text,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.view_compact),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MarkdownFormField(
                controller: _controller,
                enableToolBar: true,
                emojiConvert: true,
                autoCloseAfterSelectEmoji: false,
                isPreview: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Parse"),
      ),
      body: MarkdownParse(
        data: data,
        onTapHastag: (String name, String match) {
          // example : #hashtag
          // name => hashtag
          // match => #hashtag
        },
        onTapMention: (String name, String match) {
          // example : @mention
          // name => mention
          // match => #mention
        },
      ),
    );
  }
}
