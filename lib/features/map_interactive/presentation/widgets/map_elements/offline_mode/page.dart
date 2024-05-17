import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

class FlutterMapCachePage extends StatefulWidget {
  const FlutterMapCachePage({super.key});

  @override
  State<FlutterMapCachePage> createState() => _FlutterMapCachePageState();
}

class _FlutterMapCachePageState extends State<FlutterMapCachePage> {

  late CacheStore cacheStore;

  @override
  void initState() {
    super.initState();
    cacheStore = HiveCacheStore('default_path'); // Initialize cacheStore with a default path
  }
  // CacheStore _cacheStore = MemCacheStore();
  Future<void> fetchResultsFromCacheStore() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_map_cache'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options:  MapOptions(
                center: LatLng(36.900487, 10.192333
                ),

                maxZoom: 16,
                zoom: 15.5,
              ),
              children: [

                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileProvider: CachedTileProvider(
                    //dio: _dio,
                    maxStale: const Duration(days: 30),
                    store: cacheStore,
                    interceptors: [
                      LogInterceptor(
                        logPrint: (object) => getTemporaryDirectory().then((dir) {
                          cacheStore = HiveCacheStore(dir.path);
                          var cacheOptions = CacheOptions(
                            store: cacheStore,
                            hitCacheOnErrorExcept: [], // for offline behaviour
                          );
                          final dio = Dio()
                            ..interceptors.add(
                              DioCacheInterceptor(options: cacheOptions),
                            );
                         //dio.get(object.toString());
                          print('test ${object.toString()}');
                        }),
                        responseHeader: false,
                        requestHeader: false,
                        request: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}