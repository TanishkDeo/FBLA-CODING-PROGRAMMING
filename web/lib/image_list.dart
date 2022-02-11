import 'package:flutter/material.dart';
import 'package:web/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  Widget build(context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      },
    );
  }

  buildImage(ImageModel image) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(
              image.img,
              width: 400,
              height: 350,
            ),
            padding: EdgeInsets.only(bottom: 0.0),
          ),
          Text(image.name),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 12)),
          Text(image.desc),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 12))
        ],
      ),
    );
  }
}
