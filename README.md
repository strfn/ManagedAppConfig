#ManagedAppConfig [![Build Status](https://travis-ci.org/strfn/ManagedAppConfig.svg?branch=develop)](https://travis-ci.org/strfn/ManagedAppConfig)

ManagedAppConfig is a swift library implementing AppConfig standard for Enterprise Apps.
Check [AppConfig.org](https://www.appconfig.org/ios/) for more details (disclaimer, I'm not associated with them)

In a nutshel

1. The MDM server can send configuration to the Managed Application like usernames and server addresses.
2. The Managed App can store data within *UserDefaults* which can be remotely read by the MDM server think of it as a lightweight logging system.


Reading configs
-------------

The configurations are accessible from the singleton
```swift
ManagedAppConfig.standard
```

The configuration Dictionary is accessible via
```swift
let managedConfigs = ManagedAppConfig.standard.all
```

Accessing single configs is although the preferred approach.
```swift
let serverConfigKey = "com.managed.serveraddress"
/// the library use type inference to read the desired type
let serverURL: URL? = ManagedAppConfig.standard.read(stringConfigKey)

let usernameConfigKey = "com.managed.username"
let username = ManagedAppConfig.standard.read(stringConfigKey) as? String
```

Sending data to the MDM server
-------------

Data can be stored for future server access via ***ManagedAppFeedback.standard*** bear in mind this API is not meant to be used to send blobs or big amount of data, nor an actual log file.

The library expose an non specialised function for sending data to the server.
```swift
let bridge = ManagedAppFeedback.standard
let feedbackKey = "com.feedback.somekey"
bridge.send("The user is really happy", for: feedbackKey)
```

To clear an entry
```swift
bridge.clearFeedback(feedbackKey)
```

A common use case for managed feedback is to send back to the server session counts, error counts, timestamps for those scenario helpers methods are available:
```swift
let sessionCounterKey = "com.feedback.sessions"
//counter starts form 1 if not already set
bridge.increment(counter: sessionCounterKey)

let loginErrorCountKey = "com.feedback.loginerrors"
//when finally the user remember his password reset the error counter
bridge.reset(counter: loginErrorCountKey)

//and maybe even write down when this magic event happened.
let lastLoginTimestampKey = "com.feedback.lastlogin"
bridge.send(timestamp: Date(), withKey:  lastLoginTimestampKey)
```


