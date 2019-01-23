# CL Maps

An app to track a user’s location using CLLocationManager.
* App should capture location in the foreground and background.
* Store location points locally and display them on an Apple Map when app is launched.
* Tapping current location on map should display address using reverse-geo.

## Install
* Change 'Team' and 'BundleId' inside Project Settings to match your own

# TODOs
* Finish writing tests
* Optimize location data capturing
  * Start SCL on `applicationWillTerminate`
  * Change to SLC to recover from force-closes
  * Smartly pause continuous GPS updates when user isn't moving
    * Add region monitoring to current coord
    * Turn on SLC and wait for new update
    * Increase accuracy
  * Smartly scale-back continuous GPS updates when is moving very
   quickly over a period of time
* Add additional Realm functionality
  * Optimize `Double` type comparison
  * Extend out write blocks so objects can be property updated
* Localize any remaining strings and switch to Base Localization
* Allow non-user map annotations to be reverse geo-codable
* Fancy up the UI
* Fix any defects
