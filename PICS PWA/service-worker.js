var cacheName = 'CalcPWA';

self.addEventListener('install', event => {

  self.skipWaiting();

  event.waitUntil(
    caches.open(cacheName)
      .then(cache => cache.addAll([

        './index.html',

        './assets/bootstrap.min.js',

        './assets/js/jquery.min.js'
      ]))
  );
});

self.addEventListener('message', function (event) {
  if (event.data.action === 'skipWaiting') {
    self.skipWaiting();
  }
});

self.addEventListener('fetch', function (event) {
  //Atualizacao internet
  event.respondWith(async function () {
     try {
       return await fetch(event.request);
     } catch (err) {
       return caches.match(event.request);
     }
   }());

  //Atualizacao cache
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );

});


// This is the "Offline copy of assets" service worker

const CACHE = "pwabuilder-offline";
const QUEUE_NAME = "bgSyncQueue";

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

const bgSyncPlugin1 = new workbox.backgroundSync.BackgroundSyncPlugin(QUEUE_NAME, {
    maxRetentionTime: 24 * 60 // Retry for max of 24 Hours (specified in minutes)
});

workbox.routing.registerRoute(
    new RegExp('/*'),
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: CACHE,
        plugins: [
            bgSyncPlugin
        ]
    })
);

// This is the service worker with the - Cache-first network

const CACHE = "pwabuilder-precache";

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

workbox.routing.registerRoute(
    new RegExp('/*'),
    new workbox.strategies.CacheFirst({
        cacheName: CACHE
    })
);

//This is the service worker with the - Advanced caching

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

const HTML_CACHE = "html";
const JS_CACHE = "javascript";
const STYLE_CACHE = "stylesheets";
const IMAGE_CACHE = "images";
const FONT_CACHE = "fonts";

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

workbox.routing.registerRoute(
    ({event}) => event.request.destination === 'document',
    new workbox.strategies.NetworkFirst({
        cacheName: HTML_CACHE,
        plugins: [
            new workbox.expiration.ExpirationPlugin({
                maxEntries: 10,
            }),
        ],
    })
);

workbox.routing.registerRoute(
    ({event}) => event.request.destination === 'script',
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: JS_CACHE,
        plugins: [
            new workbox.expiration.ExpirationPlugin({
                maxEntries: 15,
            }),
        ],
    })
);

workbox.routing.registerRoute(
    ({event}) => event.request.destination === 'style',
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: STYLE_CACHE,
        plugins: [
            new workbox.expiration.ExpirationPlugin({
                maxEntries: 15,
            }),
        ],
    })
);

workbox.routing.registerRoute(
    ({event}) => event.request.destination === 'image',
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: IMAGE_CACHE,
        plugins: [
            new workbox.expiration.ExpirationPlugin({
                maxEntries: 15,
            }),
        ],
    })
);

workbox.routing.registerRoute(
    ({event}) => event.request.destination === 'font',
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: FONT_CACHE,
        plugins: [
            new workbox.expiration.ExpirationPlugin({
                maxEntries: 15,
            }),
        ],
    })
);

// This is the "Offline copy - of assets" service worker

const CACHE = "pwabuilder-offline";

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

workbox.routing.registerRoute(
    new RegExp('/*'),
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: CACHE
    })
);

// This is the "serving cached media" service worker

const CACHE = "pwabuilder-offline";

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

workbox.loadModule('workbox-cacheable-response');
workbox.loadModule('workbox-range-requests');

workbox.routing.registerRoute(
    /.*\.mp4/,
    new workbox.strategies.CacheFirst({
        cacheName: CACHE,
        plugins: [
            new workbox.cacheableResponse.CacheableResponsePlugin({statuses: [200]}),
            new workbox.rangeRequests.RangeRequestsPlugin(),
        ],
    }),
);

// backgroun - This is the "Offline copy of assets" service worker

const CACHE = "pwabuilder-offline";
const QUEUE_NAME = "bgSyncQueue";

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

const bgSyncPlugin = new workbox.backgroundSync.BackgroundSyncPlugin(QUEUE_NAME, {
    maxRetentionTime: 24 * 60 // Retry for max of 24 Hours (specified in minutes)
});

workbox.routing.registerRoute(
    new RegExp('/'),
    new workbox.strategies.StaleWhileRevalidate({
        cacheName: CACHE,
        plugins: [
            bgSyncPlugin
        ]
    })
);

// This is the "Offline page" service worker

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

const CACHE = "pwabuilder-page";

// TODO: replace the following with the correct offline fallback page i.e.: const offlineFallbackPage = "offline.html";
const offlineFallbackPage = "offline.html";

self.addEventListener("message", (event) => {
    if (event.data && event.data.type === "SKIP_WAITING") {
        self.skipWaiting();
    }
});

self.addEventListener('install', async (event) => {
    event.waitUntil(
        caches.open(CACHE)
            .then((cache) => cache.add(offlineFallbackPage))
    );
});

if (workbox.navigationPreload.isSupported()) {
    workbox.navigationPreload.enable();
}

self.addEventListener('fetch', (event) => {
    if (event.request.mode === 'navigate') {
        event.respondWith((async () => {
            try {
                const preloadResp = await event.preloadResponse;

                if (preloadResp) {
                    return preloadResp;
                }

                const networkResp = await fetch(event.request);
                return networkResp;
            } catch (error) {

                const cache = await caches.open(CACHE);
                const cachedResp = await cache.match(offlineFallbackPage);
                return cachedResp;
            }
        })());
    }
});

// periodic sync
//consultando
const status = await navigator.permissions.query({
    name: 'periodic-background-sync',
});
if (status.state === 'granted') {
    // Periodic background sync can be used.
} else {
    // Periodic background sync cannot be used.
}

//registrando
const registration6 = await navigator.serviceWorker.ready;
if ('periodicSync' in registration) {
    try {
        await registration.periodicSync.register('content-sync', {
            // An interval of one day.
            minInterval: 24 * 60 * 60 * 1000,
        });
    } catch (error) {
        // Periodic background sync cannot be used.
    }
}

//verificar registro
const registration7 = await navigator.serviceWorker.ready;
if ('periodicSync' in registration) {
    const tags = await registration.periodicSync.getTags();
    // Only update content if sync isn't set up.
    if (!tags.includes('content-sync')) {
        updateContentOnPageLoad();
    }
} else {
    // If periodic background sync isn't supported, always update.
    updateContentOnPageLoad();
}

//Respondendo a um evento periódico de sincronização em segundo plano
self.addEventListener('periodicsync', (event) => {
    if (event.tag === 'content-sync') {
        // See the "Think before you sync" section for
        // checks you could perform before syncing.
        event.waitUntil(syncContent());
    }
    // Other logic for different tags as needed.
});

//Cancelando o registro de uma sincronização
const registration = await navigator.serviceWorker.ready;
if ('periodicSync' in registration) {
    await registration.periodicSync.unregister('content-sync');
}

//atualizando conteudo periodicamente em segundo plano
async function updateArticles() {
    const articlesCache = await caches.open('articles');
    await articlesCache.add('/api/articles');
}

self.addEventListener('periodicsync', (event) => {
    if (event.tag === 'update-articles') {
        event.waitUntil(updateArticles());
    }
});
