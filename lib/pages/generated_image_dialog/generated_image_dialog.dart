import 'package:dog_appnation/service/dog_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneratedImageDialog extends StatelessWidget {
  const GeneratedImageDialog({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LayoutBuilder(
                builder: (context,constraints) {
                  return FadeInImage.assetNetwork(
                      placeholder: "assets/images/dog_placeholder.png",
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/dog_placeholder.png");
                      },
                      image: imgUrl,
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.fill,
                    );
                }
              ),
            ),
          ),
          SizedBox(height: 8),
          IconButton(
              onPressed: () {
                context.pop();
              },
              style: IconButton.styleFrom(
                  alignment: Alignment.center,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black),
              icon: Icon(Icons.close, color: Colors.black))
        ],
      ),
    );
  }
}
