import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:advanced_flutter/infra/cache/adapters/cache_manager_adapter.dart';

CacheManagerAdapter makeCacheManagerAdapter() {
  return CacheManagerAdapter(client: DefaultCacheManager());
}
