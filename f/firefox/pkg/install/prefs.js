// Open links from external programs in new tabs in an existing window
pref("browser.link.open_external",          3);
pref("browser.newtabpage.activity-stream.disableSnippets", true);
pref("browser.newtabpage.activity-stream.feeds.snippets", false);
pref("browser.newtabpage.pinned",           '[{"url":"https://aerynos.com/blog/","title":"Blogs | AerynOS"}]');
// Default browser check
pref("browser.shell.checkDefaultBrowser",   false);
// Set default homepage
pref("browser.startup.homepage",            "https://aerynos.com/blog/");
// Needed for loading langpacks
pref("extensions.autoDisableScopes",        0);
// Do not recommend extensions
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
// Display settings for the extension being installed
pref("extensions.shownSelectionUI",         true);
// Geolocation preferences
pref("geo.provider.network.url", "https://api.beacondb.net/v1/geolocate");
pref("offline.autoDetect",                  true);
pref("spellchecker.dictionary_path", "/usr/share/hunspell");
// Default homepage override URL
pref("startup.homepage_override_url",       "");
// False = Use NetworkManager to detect offline/online status, and switch between offline/online modes in Firefox
pref("toolkit.networkmanager.disable",      false);
pref("ui.context_menus.after_mouseup",      true);
// Allow gnome search provider to function by default
pref("browser.gnome-search-provider.enabled", true);
