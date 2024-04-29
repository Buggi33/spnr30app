import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:spnr30app/components/my_firebase_file.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;
  const ImagePage({
    super.key,
    required this.file,
  });

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late Future<ListResult> futureFiles;
  late Reference fileReference;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/SnowRunner').listAll();
    fileReference = FirebaseStorage.instance.refFromURL(widget.file.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
//enable to zoom in and zoom out
          PhotoView(
            imageProvider: NetworkImage(widget.file.url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          ),
          Positioned(
            top: 50,
            left: 8,
            child: IconButton(
                icon: Icon(
                  size: 25,
                  color: const Color.fromARGB(255, 245, 26, 64),
                  Icons.arrow_back,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
          Positioned(
            bottom: 50,
            right: 170,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 26, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Icon(size: 20, color: Colors.white, Icons.download),
              onPressed: () {
                downloadFile(fileReference);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future downloadFile(Reference ref) async {
    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path);

    if (url.contains('.mp4')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloaded ${ref.name}'),
      ),
    );
  }
}
