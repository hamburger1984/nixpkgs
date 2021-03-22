{ mkDerivation, fetchurl, lib, makeWrapper
, extra-cmake-modules, qtbase, kdoctools, wrapGAppsHook, wrapQtAppsHook
, kconfig, kconfigwidgets, kcrash, kdbusaddons, kinit, kio, kjobwidgets, kpmcore
, cryptsetup, lvm2, mdadm, smartmontools, systemdMinimal, util-linux
, btrfs-progs, dosfstools, e2fsprogs, eject, exfat, f2fs-tools, fatresize, hfsprogs
, jfsutils, libatasmart, nilfs-utils, ntfs3g, polkit-qt, reiser4progs, reiserfsprogs, udftools, xfsprogs, zfs
}:

let
  # External programs are resolved by `partition-manager` and then
  # invoked by `kpmcore_externalcommand` from `kpmcore` as root.
  # So these packages should be in PATH of `partition-manager`.
  # https://github.com/KDE/kpmcore/blob/06f15334ecfbe871730a90dbe2b694ba060ee998/src/util/externalcommand_whitelist.h
  runtimeDeps = lib.makeBinPath [
    cryptsetup
    lvm2
    mdadm
    smartmontools
    systemdMinimal
    util-linux

    btrfs-progs
    dosfstools
    e2fsprogs
    exfat
    f2fs-tools
    fatresize
    hfsprogs
    jfsutils
    nilfs-utils
    ntfs3g
    reiser4progs
    reiserfsprogs
    udftools
    xfsprogs
    zfs

    # FIXME: Missing command: tune.exfat hfsck hformat fsck.nilfs2 {fsck,mkfs,debugfs,tunefs}.ocfs2
  ];

in mkDerivation {
  pname = "partitionmanager";

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
