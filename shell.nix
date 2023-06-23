with import <nixpkgs> { };
let
  pkgs-unstable = import <nixpkgs-unstable> { };
  fhs = pkgs.buildFHSUserEnv
    {
      name = "buildroot-env";

      targetPkgs = pkgs: with pkgs; [
        # pull in build-requirements
        androidenv.androidPkgs_9_0.platform-tools
        autoconf
        automake
        bc
        bison
        cacert
        cpio
        cscope
        curl
        dtc
        expect
        file
        flex
        pkgs-unstable.gcc-arm-embedded
	glibc
        git
        gitRepo
        gnumake
        gnutar
        gptfdisk
        hostname
        # iasl -> acpica-tools
        libtool
	libxcrypt
        m4
        mtools
        netcat
        perl
        pkgconfig
        rsync
        unzip
        wget
        which
        xdg_utils
        xterm
        xz

        # and some useful additions
        ccache
        coreutils
        ninja
        screen

        # required libs for linking
        attr
        db
        file
        gdbm
        glib
        glibc
        glibc_multi
        gmp
        hidapi
        libcap
        libuuid
        linuxHeaders
        ncurses
        openssl
        pixman
        zlib
        readline
      ];

      # multiPkgs = pkgs: with pkgs; [
      #   readline
      # ];

      profile = ''
        export PATH="${file}/bin:$PATH"
        export ENVFS_RESOLVE_ALWAYS="1"
	export LD_LIBRARY_PATH=${pkgs-unstable.gcc-arm-embedded}/lib:$LD_LIBRARY_PATH
      '';
      extraOutputsToInstall = [ "dev" ];
    };
in
fhs.env
