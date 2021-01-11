{
mkDerivation
, lib
, extra-cmake-modules
#, wrapGAppsHook
#, wrapQtAppsHook

, kconfig
, kconfigwidgets
, kcrash
, kdbusaddons
, kdoctools
, kio
, kjobwidgets
#, kinit
#, kparts
, kpmcore
#, kservice
#, libatasmart
, polkit-qt
, qtbase

#, btrfs-progs
#, e2fsprogs
#, exfat-utils
#, dosfstools
#, lvm2
#, ntfs3g
#, xfsprogs
#, zfs
#, eject

, util-linux

}:

mkDerivation {
  pname = "partitionmanager";

#  enableParallelBuilding = true;

  nativeBuildInputs = [ extra-cmake-modules ];

  cmakeFlags = [
    "-DCMAKE_VERBOSE_MAKEFILE=True"
    #"-DKPMCORE_INCLUDE_DIR=${lib.getDev kpmcore}/include/kpmcore"
  ];

  buildInputs = [
    qtbase

    #eject

    kconfig
    kconfigwidgets
    kcrash
    kdbusaddons
    kdoctools
    kio
    kjobwidgets

    kpmcore.out
    #kservice.dev

    polkit-qt

    #libatasmart

    util-linux
  ];
#  propagatedBuildInputs = [ kconfig kcrash kinit kpmcore ];

#  dontWrapGApps = true;

  postPatch = ''
    sed -i "s|\''${POLKITQT-1_POLICY_FILES_INSTALL_DIR}|''${out}/share/polkit-1/actions|" src/util/CMakeLists.txt
  '';

  meta = with lib; {
    description = "KDE Partition Manager";
    license = licenses.gpl2;
    homepage = "https://www.kde.org/applications/system/kdepartitionmanager/";
    maintainers = with maintainers; [ peterhoeg ];
  };
}
