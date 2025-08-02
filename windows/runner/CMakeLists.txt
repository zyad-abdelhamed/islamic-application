cmake_minimum_required(VERSION 3.14)

# إنشاء الملف التنفيذي باسم داخلي (ASCII)
add_executable(noor
  "main.cpp"
  "runner.exe.manifest"
)

# إعدادات التجميع القياسية
target_compile_definitions(noor PRIVATE "UNICODE" "_UNICODE")
target_compile_features(noor PUBLIC cxx_std_17)
target_compile_options(noor PRIVATE /W4 /WX /wd"4100")
target_compile_options(noor PRIVATE /EHsc)
target_compile_definitions(noor PRIVATE "_HAS_EXCEPTIONS=0")
target_compile_definitions(noor PRIVATE "$<$<CONFIG:Debug>:_DEBUG>")

# تضمين ملفات الرأس من Flutter
target_include_directories(noor PRIVATE
  "${CMAKE_SOURCE_DIR}/flutter"
)

# ربط المكتبات بأسلوب keyword (لتفادي خطأ CMake)
target_link_libraries(noor
  PUBLIC flutter
  PUBLIC shlwapi
)

# إعدادات لمصحح Visual Studio
set_property(TARGET noor PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "$<TARGET_FILE_DIR:noor>")
