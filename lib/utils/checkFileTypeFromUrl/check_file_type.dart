import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/src/file_enums.dart';

class CheckFileType
{
  static FileTypeEnum checkFileType(String? url)
  {
    String fileType = _getFileType(url);
    switch(fileType)
        {
      case 'pdf':
        return FileTypeEnum.pdf;
      case 'png':
        return FileTypeEnum.png;
      case 'jpg':
        return FileTypeEnum.jpg;
      case 'jpeg':
        return FileTypeEnum.jpeg;
      default:
        return FileTypeEnum.unknown;

    }
  }

  static String _getFileType(String? url) {
    if(url == null)
      {
        return '';
      }
    final uri = Uri.parse(url);
    final segments = uri.pathSegments; // Extract path segments
    final lastSegment = segments.isNotEmpty ? segments.last : '';

    if (lastSegment.isEmpty) {
      return ''; // Handle empty URL or no segments
    }

    final parts = lastSegment.split('.'); // Split by '.'
    return parts.length > 1 ? parts.last.toLowerCase() : ''; // Return lowercase extension
  }
}