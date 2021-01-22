{ mkDerivation, fetchurl, lib, makeWrapper
, extra-cmake-modules, kdoctools, wrapGAppsHook, wrapQtAppsHook
, kconfig, kconfigwidgets, kcrash, kdbusaddons, kdoctools, kinit, kio, kjobwidgets, kpmcore
, cryptsetup, lvm2, mdadm, smartmontools, systemdMinimal, util-linux
, btrfs-progs, dosfstools, e2fsprogs, exfat, f2fs-tools, fatresize, hfsprogs
, jfsutils, libatasmarts, nilfs-utils, ntfs3g, polkit-qt, reiser4progs, reiserfsprogs, udftools, xfsprogs, zfs
}:

mkDerivation {
  pname = "partitionmanager";

#  enableParallelBuilding = true;

  nativeBuildInputs = [ extra-cmake-modules kdoctools ];

  cmakeFlags = [
    "-DCMAKE_VERBOSE_MAKEFILE=True"
    #"-DKPMCORE_INCLUDE_DIR=${lib.getDev kpmcore}/include/kpmcore"
  ];

  buildInputs = [
    qtbase

    kconfig
    kconfigwidgets
    kcrash
    kdbusaddons
    kio
    kjobwidgets

    kpmcore.out
    #kservice.dev

    eject
    polkit-qt

    libatasmart

    util-linux
  ];

  nativeBuildInputs = [ extra-cmake-modules kdoctools wrapGAppsHook wrapQtAppsHook makeWrapper ];

  propagatedBuildInputs = [ kconfig kcrash kinit kpmcore ];

  postFixup = ''
    wrapProgram $out/bin/partitionmanager \
      --prefix PATH : "${runtimeDeps}"
  '';

  postPatch = ''
    sed -i "s|\''${POLKITQT-1_POLICY_FILES_INSTALL_DIR}|''${out}/share/polkit-1/actions|" src/util/CMakeLists.txt
  '';

  meta = with lib; {
    description = "KDE Partition Manager";
    license = with licenses; [ cc-by-40 cc0 gpl3Plus lgpl3Plus mit ];
    homepage = "https://www.kde.org/applications/system/kdepartitionmanager/";
    maintainers = with maintainers; [ peterhoeg oxalica ];
  };
}
