import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';

class ViewPhoto extends StatefulWidget {
  final List<String> galleryItems;
  String? path;
  int currentPage = 0;
  ViewPhoto(
      {Key? key,
      required this.galleryItems,
      required this.path,
      this.currentPage = 0})
      : super(key: key);

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  final PhotoViewController controller = PhotoViewController();
  final PhotoViewScaleStateController stateController = PhotoViewScaleStateController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoViewGallery.builder(
          builder: (BuildContext context, int index) {
            return widget.path == null ? PhotoViewGalleryPageOptions(
              imageProvider:  AssetImage(widget.galleryItems[index]),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes:
              PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
              minScale: PhotoViewComputedScale.contained * 0.8,
              controller: controller,
              scaleStateController: stateController,
            )  : PhotoViewGalleryPageOptions(
              imageProvider:  BaseHelper.loadNetworkImageObject(
                  widget.path! + widget.galleryItems[widget.currentPage]),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: widget.galleryItems[widget.currentPage]),
              minScale: PhotoViewComputedScale.contained * 0.8,
              controller: controller,
              scaleStateController: stateController,
            );
          },
          itemCount: widget.galleryItems.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: const CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          backgroundDecoration:
              BoxDecoration(color: Colors.black38.withOpacity(0.5)),
          // pageController: widget.pageController,
          onPageChanged: (val) {
            setState(() {
              controller.updateMultiple(position: Offset(0.0, 0.0));
              print(val);
              widget.currentPage = val;
            });
          },
        ),
        Positioned(
          top: 0,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: IconButton(
                onPressed: () => navigationController.goBack(),
                icon: Icon(Icons.highlight_off, color: AppTheme.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
