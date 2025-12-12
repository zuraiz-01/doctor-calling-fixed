plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter Plugin MUST remain here
    id("dev.flutter.flutter-gradle-plugin")

    //  ADD THIS (Firebase Google Services)
   // id("com.google.gms.google-services")
}

android {
    namespace = "com.beh.eyedoctor"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        //  IMPORTANT — Use your real applicationId, NOT example
         applicationId ="com.beh.eyedoctor"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

//  Firebase requires this — MUST be at bottom
//apply plugin: "com.google.gms.google-services"
