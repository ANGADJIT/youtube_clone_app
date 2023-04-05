import 'package:image_picker/image_picker.dart';

class MediaManager {
  final ImagePicker _mediaManager = ImagePicker();

  Future<String?> getImage() async {
    final image = await _mediaManager.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image.path;
    }

    return null;
  }

  Future<String?> getVideo() async {
    final video = await _mediaManager.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      return video.path;
    }

    return null;
  }
}
