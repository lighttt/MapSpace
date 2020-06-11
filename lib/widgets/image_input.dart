import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final _imagePicker = ImagePicker();

  Future<void> _takePicture() async {
    final image =
        await _imagePicker.getImage(source: ImageSource.camera, maxWidth: 600);

    if (image == null) {
      return;
    }
    setState(() {
      _storedImage = File(image.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    // /sdcard/0/com.manishtuladhar.mapspace/data/202013123.jpg
    final fileName = path.basename(image.path);
    final saveImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage == null
              ? Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text("Take a Picture"),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
