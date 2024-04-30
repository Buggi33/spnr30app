import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:spnr30app/components/my_firebase_file.dart';

class PhotoGalleryPage extends StatefulWidget {
  final FirebaseFile file;
  final Future<List<FirebaseFile>> futureFiles;
  final int initialIndex;
  const PhotoGalleryPage({
    super.key,
    required this.file,
    required this.futureFiles,
    required this.initialIndex,
  });

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  late Future<List<FirebaseFile>> futureFiles;
  late Reference fileReference;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    // futureFiles = FirebaseStorage.instance.ref('/SnowRunner').listAll();
    fileReference = FirebaseStorage.instance.refFromURL(widget.file.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<List<FirebaseFile>>(
            future: widget.futureFiles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error!'));
              } else {
                final files = snapshot.data!;
                return PhotoViewGallery.builder(
                  pageController: _pageController,
                  onPageChanged: (index) {
                    _pageController.jumpToPage(index);
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  builder: (context, index) {
                    final file = files[index];
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(file.url),
                      initialScale: PhotoViewComputedScale.contained,
//jak daleko można oddalić - 1 (wraca do swojej minimalnej wielkości)
                      minScale: PhotoViewComputedScale.contained * 1,
//jak bardzo można przybliżyć - 1 (wraca do swojej maksymalnej wielkości)
                      maxScale: PhotoViewComputedScale.covered * 1.5,
                    );
                  },
                );
              }
            },
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
            right: 163,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 26, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Icon(size: 20, color: Colors.white, Icons.download),
              onPressed: () {
                downloadFile(_pageController.page!.toInt(), widget.futureFiles);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future downloadFile(int index, Future<List<FirebaseFile>> futureFiles) async {
    final files = await futureFiles;
    final FirebaseFile file = files[index];
    final ref = FirebaseStorage.instance.refFromURL(file.url);

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
