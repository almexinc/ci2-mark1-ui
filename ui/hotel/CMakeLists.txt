cmake_minimum_required(VERSION 3.16)

project(hotel VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(root_path ${CMAKE_CURRENT_SOURCE_DIR}/../../)

# ここに追加した後、target_link_librariesにも追加を忘れずに。
find_package(Qt6 REQUIRED COMPONENTS Quick LinguistTools Mqtt)

# プリプロセッサ定義
add_definitions(
    -DROOT_PATH="${root_path}"
)

qt_standard_project_setup(REQUIRES 6.5)

# 翻訳用のTS（Translation Source）ファイルのリストを定義
set(TS_FILES
    translations/hotel_ja.ts
    translations/hotel_ko.ts
    translations/hotel_fr.ts
    translations/hotel_en.ts
)

# ソースコード記載場所
include(source.cmake)
include(../common/source.cmake)

qt_add_executable(apphotel
    main.cpp
    ${COMMON_BUILD_CPP_SOURCES}
    ${HOTEL_BUILD_CPP_SOURCES}
)

# インクルードディレクトリを追加
target_include_directories(apphotel PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    C:/Qt/6.5.3/msvc2019_64/include/QtMqtt
)

# 翻訳を追加
qt_add_translations(apphotel
    TS_FILES ${TS_FILES}

    # 必要に応じてオプションを追加
    # LRELEASE_OPTIONS
    # RESOURCE_PREFIX "/translations"  # qrc内でのパスプレフィックス
)

# Windows上のMSVCコンパイラの場合、警告レベルを最大に設定
if(MSVC)
    # /W4: 警告レベル4
    # /WX: 警告をエラーとして扱う
    # /Wall: (注意して使用) すべての警告を有効にする。ノイズが多い可能性あり。
    # /analyze: (ビルド時間が長くなる) 静的コード分析を実行
    target_compile_options(apphotel PRIVATE
        /W4 # 実用的な最大警告レベル
        /WX # 警告をエラーとして扱う
        /utf-8

        # /Wall  # 必要に応じて。ただしノイズが多いことに注意
    )
endif()

set(QML_IMPORT_PATH "${CMAKE_SOURCE_DIR}/qml" "${CMAKE_CURRENT_BINARY_DIR}/qml")

qt_add_resources(RESOURCES_QRC
    qml.qrc
)

target_sources(apphotel
    PRIVATE
    ${RESOURCES_QRC}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apphotel PROPERTIES

    # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apphotel
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apphotel
    PRIVATE Qt6::Quick Qt6::Mqtt
)

include(GNUInstallDirs)
install(TARGETS apphotel
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
