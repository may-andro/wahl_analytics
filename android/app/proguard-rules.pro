-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes SourceFile,LineNumberTable

#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }

# --- Flutter Keep Rules ---
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# --- Keep Generated Plugins ---
-keep class *.GeneratedPluginRegistrant { *; }

# --- Common Reflection-related Keeps ---
-keepattributes *Annotation*
-keepattributes Signature

# --- Firebase (if using) ---
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# --- Keep Flutter plugins (if dynamic loading used) ---
-keep class io.flutter.plugin.** { *; }