import 'package:uuid/uuid.dart';

import '../../service_locator.dart';

class IdService {
  final Uuid _uuid = sl<Uuid>();

  String generateRandomId() {
    return _uuid.v1();
  }
}