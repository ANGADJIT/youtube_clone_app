import 'package:image_picker/image_picker.dart';

class MediaManager {
  final ImagePicker _mediaManager = ImagePicker();

  Future<String?> getImage({bool fromCamera = false}) async {
    final image = await _mediaManager.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      return image.path;
    }

    return null;
  }

  Future<String?> getVideo({bool fromCamera = false}) async {
    final video = await _mediaManager.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);

    if (video != null) {
      return video.path;
    }

    return null;
  }
}
