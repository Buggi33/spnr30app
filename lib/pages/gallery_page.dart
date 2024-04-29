import 'package:flutter/material.dart';
import 'package:spnr30app/api/FirebaseApi.dart';
import 'package:spnr30app/components/my_firebase_file.dart';
import 'package:spnr30app/pages/photo_gallery_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
//set a current folder in firebase
    futureFiles = FirebaseApiGallery.listAll('/SnowRunner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 245, 26, 64),
        backgroundColor: const Color.fromARGB(255, 0, 39, 73),
        shadowColor: Colors.black,
        elevation: 5,
        centerTitle: true,
        title: const Text("G A L E R I A"),
      ),
      body: Column(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                  style: TextStyle(color: Colors.grey),
                  'Rozmiar i ilość zdjęć wpływa na szybkość wczytywania'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FirebaseFile>>(
              future: futureFiles,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Center(child: Text('Error!'));
                    } else {}
                    final files = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              return buildFile(context, file, futureFiles);
                            },
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file,
          Future<List<FirebaseFile>> futureFiles) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          child: Image.network(file.url),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  PhotoGalleryPage(file: file, futureFiles: futureFiles),
            ),
          ),
        ),
      );
}
