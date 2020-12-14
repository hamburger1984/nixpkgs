{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  qtbase, qtdeclarative, qtquickcontrols, qtquickcontrols2,
  kcmutils, kcompletion, kconfig, kconfigwidgets, kcoreaddons, kdbusaddons,
  kdeclarative, kdelibs4support, ki18n, kiconthemes, kio, kirigami2, kpackage,
  kservice, kwayland, kwidgetsaddons, kxmlgui, libraw1394, libGLU, pciutils,
  solid, systemsettings
}:

mkDerivation {
  name = "kinfocenter";
  #meta.broken = lib.versionOlder qtbase.version "5.15.0";
  nativeBuildInputs = [ extra-cmake-modules kdoctools systemsettings ];
  buildInputs = [
    qtdeclarative qtquickcontrols qtquickcontrols2
    kcmutils kcompletion kconfig kconfigwidgets kcoreaddons kdbusaddons
    kdeclarative kdelibs4support ki18n kiconthemes kio kirigami2 kpackage
    kservice kwayland kwidgetsaddons kxmlgui libraw1394 libGLU pciutils solid
    systemsettings
  ];
  #propagatedBuildInputs = [ systemsettings ];
  patchPhase = ''
    # It seems that there is a bug in qtdeclarative: qmlplugindump fails
    # because it can not find or load the Qt platform plugin "minimal".
    # A workaround is to set QT_PLUGIN_PATH and QML2_IMPORT_PATH explicitly.
    export QT_PLUGIN_PATH=${qtbase.bin}/${qtbase.qtPluginPrefix}
    export QML2_IMPORT_PATH=${qtdeclarative.bin}/${qtbase.qtQmlPrefix}

    #substituteInPlace GSettings/gsettings-qt.pro \
    #  --replace '$$[QT_INSTALL_QML]' "$out/$qtQmlPrefix" \
    #  --replace '$$[QT_INSTALL_BINS]/qmlplugindump' "qmlplugindump"

    #substituteInPlace src/gsettings-qt.pro \
    #  --replace '$$[QT_INSTALL_LIBS]' "$out/lib" \
    #  --replace '$$[QT_INSTALL_HEADERS]' "$out/include"
  '';
}
