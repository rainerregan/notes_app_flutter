import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/pages/add_new_note.dart';
import 'package:notes_app_flutter/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length > 0) ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index) {
            // Get the current note based on index
            Note currentNote = notesProvider.notes[index];

            return GestureDetector(
              onTap: () {
                // Update
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => AddNewNotePage(isUpdate: true, note: currentNote)),
                );
              },
              onLongPress: () {
                // Delete
                notesProvider.deleteNote(currentNote);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentNote.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      currentNote.content!,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            );
          },
        ) : const Center(
          child: Text("No notes yet. Click + to create one"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddNewNotePage(isUpdate: false,),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
