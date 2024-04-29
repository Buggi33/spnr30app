// // /fetch firebase store to app
//   static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
//       Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

//   static Future<List<FirebaseFile>> listAll(String path) async {
//     final ref = FirebaseStorage.instance.ref(path);
//     final result = await ref.listAll();

//     final urls = await _getDownloadLinks(result.items);

//     return urls
//         .asMap()
//         .map((index, url) {
//           final ref = result.items[index];
//           final name = ref.name;
//           final file = FirebaseFile(ref: ref, name: name, url: url);
//           return MapEntry(index, file);
//         })
//         .values
//         .toList();
//   }

//   bool loading = false;

//   Future<bool> saveFile(String url, String fileName) async {
//     Directory? directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           if (directory != null) print(directory.path);
//           String newPath = "";
//           List<String> folders = directory?.path.split("/") ?? [];
//           for (int x = 1; x < folders.length; x++) {
//             String folder = folders[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/SPNR30PICS";
//           directory = Directory(newPath);
//           print(directory.path);
//         } else {
//           return false;
//         }
//       } else {}
//     } catch (e) {}
//     return false;
//   }

//   _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }

//   downloadFile() async {
//     setState(() {
//       loading = true;
//     });

//     bool downloaded = await saveFile(
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Google_Photos_icon_%282020%29.svg/1024px-Google_Photos_icon_%282020%29.svg.png',
//         'pic.png');
//     if (downloaded) {
//       print("File Downloaded");
//     } else {
//       print("Problem Downloading file");
//     }
//     setState(() {
//       loading = false;
//     });
//   }