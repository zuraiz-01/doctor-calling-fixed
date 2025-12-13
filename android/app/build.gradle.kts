import java.util.Properties
import java.io.File
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter Plugin MUST remain here
    id("dev.flutter.flutter-gradle-plugin")
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
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.beh.eyedoctor"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

 signingConfigs {
    create("release") {
        val propsFile = rootProject.file("key.properties")
        if (propsFile.exists()) {
            val keystoreProps = Properties()
            keystoreProps.load(FileInputStream(propsFile))

            storeFile = rootProject.file(keystoreProps["storeFile"] as String)
            storePassword = keystoreProps["storePassword"] as String
            keyAlias = keystoreProps["keyAlias"] as String
            keyPassword = keystoreProps["keyPassword"] as String
        }
    }
}


    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("release")
        }

        getByName("debug") {
            // Use default Flutter debug keystore
            // No need to assign signingConfig explicitly
        }
    }
}

flutter {
    source = "../.."
}
