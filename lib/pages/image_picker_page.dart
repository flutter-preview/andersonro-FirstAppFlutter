import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker picker = ImagePicker();
  XFile? photo = null;

  croppImage(XFile imageFile) async {

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if(croppedFile != null) {
      await GallerySaver.saveImage("${croppedFile.path}");
      photo = XFile(croppedFile.path);
      setState(() {});
    }


  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: const FaIcon(FontAwesomeIcons.camera),
                                title: const Text("Camera"),
                                onTap: () async {
                                  photo = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (photo != null) {
                                    String path = (await path_provider
                                            .getApplicationDocumentsDirectory())
                                        .path;
                                    String name = p.basename(photo!.path);
                                    await photo!.saveTo("${path}/${name}");
                                    await GallerySaver.saveImage(
                                        "${path}/${name}");
                                    setState(() {});
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              ListTile(
                                leading: const FaIcon(FontAwesomeIcons.images),
                                title: const Text("Galeria"),
                                onTap: () async {
                                  photo = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                  Navigator.pop(context);
                                  croppImage(photo!);

                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("Show")),

              Expanded(
                child: Container(
                  child: (photo != null
                      ? Image.file(File(photo!.path))
                      : Text("Nenhuma imagem")),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
