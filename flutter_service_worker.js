'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "17e6d312007614183ea06893b8d4bd72",
"version.json": "59e0ab6d0b3077df875c52c38160d845",
"index.html": "b6ad83c1675ad069020b0390ff3ee46a",
"/": "b6ad83c1675ad069020b0390ff3ee46a",
"main.dart.js": "7ff123c6f27a0caa4f31f894a32b2dc9",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "e54b1232f63387a5f30c6153487ebdcc",
"icons/Icon-192.png": "498b06cd062e92816f65f742bb662835",
"icons/Icon-maskable-192.png": "498b06cd062e92816f65f742bb662835",
"icons/Icon-maskable-512.png": "f48d6dff9b2e1d49761eaead10ee5fbc",
"icons/Icon-512.png": "f48d6dff9b2e1d49761eaead10ee5fbc",
"manifest.json": "a5ff3e8649ba6be31bccb2a776292a2d",
"assets/AssetManifest.json": "54c291b994f2df399d46bb5684689224",
"assets/NOTICES": "3730494981d3b2c2d309c4d6c0e994d7",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "1d0c1193ce673521ed8ecf9143843352",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2b04d768ed9dd27e56f1971eb151ab78",
"assets/fonts/MaterialIcons-Regular.otf": "f637300afb33971ec1bee6f7ba020019",
"assets/assets/cuisine/dry_rice_noodle.jpg": "2a244db935cd40736604ce85711a5364",
"assets/assets/cuisine/wonton_soup.jpg": "e3b75932eb16a055769b59cf66dc40d5",
"assets/assets/cuisine/dry_noodle_with_sauce.jpg": "f6ec58bcda7d4381b4d11a75c05e7469",
"assets/assets/cuisine/buns.jpg": "03dda785ff66f2d30eec0cf7807febb2",
"assets/assets/cuisine/turnip_cake.jpg": "e97f4bf75b42df08a43be006fd62db15",
"assets/assets/cuisine/jute_soup.jpg": "14c19d7a34b1b4d0260f254ec564d4ec",
"assets/assets/cuisine/vegetarian.jpg": "588302f1418d35045b531ad07f2b2f70",
"assets/assets/cuisine/ice.jpg": "3d858bed31d4417e8c650525e1bb7151",
"assets/assets/cuisine/sushi.jpg": "b89882d39afe070361e897f653dd4842",
"assets/assets/cuisine/taiwanese_meatball.jpg": "d4f494125bbe5697416ae6b9592c3005",
"assets/assets/cuisine/sashimi.jpg": "4f0fa2cc04760c8989d79af8638917ca",
"assets/assets/cuisine/drinks.jpg": "a1bb36a86d72911273fad174545f3874",
"assets/assets/cuisine/cooked_side_dishes.jpg": "61e37a60dbf527300749cd6d1b5afebc",
"assets/assets/cuisine/braised_pork_rice.jpg": "d0e43c6d4a27414a7b2eddc70817802b",
"assets/assets/cuisine/stir_fry.jpg": "8b25ac253a86e771f757dbe22b1fce68",
"assets/assets/cuisine/meat_puff.jpg": "996c6272349f48dccef6d94a9a2f9795",
"assets/assets/mktLogo.png": "79d61d290f1aa109b91397d4bf4388f8",
"assets/assets/background.png": "7eaee6a848c8fc6fdc32733c2d8436c2",
"assets/assets/walkingPerson.gif": "cef6a52b1d50d6127f652c52a3de3192",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
