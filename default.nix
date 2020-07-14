let
  sources = import ./nix/sources.nix;

  pkgs = import sources.nixpkgs { };

  release = version: {
    name = "emacs-${version}";
    src = sources."emacs-${version}";
  };
in
# Some versions do not currently build on MacOS, so we do not even
  # expose them on that platform.
(
  if pkgs.stdenv.isLinux then {

    emacs-23-4 = with pkgs; callPackage ./emacs.nix {
      inherit (release "23.4") name src;
      withAutoReconf = false;
      stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
      patches = [
        ./patches/all-dso-handle.patch
        ./patches/fpending-23.4.patch
      ];
      needCrtDir = true;
    };

    emacs-24-1 = with pkgs; callPackage ./emacs.nix {
      inherit (release "24.1") name src;
      withAutoReconf = false;
      stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
      patches = [
        ./patches/all-dso-handle.patch
        ./patches/remove-old-gets-warning.patch
        ./patches/fpending-24.1.patch
      ];
    };

    emacs-24-2 = with pkgs; callPackage ./emacs.nix {
      inherit (release "24.2") name src;
      withAutoReconf = false;
      stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
      patches = [ ./patches/all-dso-handle.patch ./patches/fpending-24.1.patch ];
    };
  } else { }
) // {
  emacs-24-3 = with pkgs; callPackage ./emacs.nix {
    inherit (release "24.3") name src;
    withAutoReconf = false;
    stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
    patches = [ ./patches/all-dso-handle.patch ./patches/fpending-24.3.patch ];
  };

  emacs-24-4 = with pkgs; callPackage ./emacs.nix {
    inherit (release "24.4") name src;
    withAutoReconf = false;
    stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
    patches = [ ./patches/gnutls-e_again.patch ];
  };

  emacs-24-5 = with pkgs; callPackage ./emacs.nix {
    inherit (release "24.5") name src;
    withAutoReconf = false;
    stdenv = if stdenv.cc.isGNU then gcc49Stdenv else stdenv;
    patches = [ ./patches/gnutls-e_again.patch ];
  };

  emacs-25-1 = pkgs.callPackage ./emacs.nix {
    inherit (release "25.1") name src;
    withAutoReconf = true;
    patches = [
      ./patches/gnutls-use-osx-cert-bundle.patch
      ./patches/gnutls-e_again.patch
    ];
  };

  emacs-25-2 = pkgs.callPackage ./emacs.nix {
    inherit (release "25.2") name src;
    withAutoReconf = true;
    patches = [
      ./patches/gnutls-use-osx-cert-bundle.patch
      ./patches/gnutls-e_again.patch
    ];
  };

  emacs-25-3 = pkgs.callPackage ./emacs.nix {
    inherit (release "25.3") name src;
    withAutoReconf = true;
    patches = [
      ./patches/gnutls-use-osx-cert-bundle.patch
      ./patches/gnutls-e_again.patch
    ];
  };

  emacs-26-1 = pkgs.callPackage ./emacs.nix {
    inherit (release "26.1") name src;
    withAutoReconf = true;
    patches = [ ./patches/gnutls-e_again.patch ];
  };

  emacs-26-2 = pkgs.callPackage ./emacs.nix {
    inherit (release "26.2") name src;
    withAutoReconf = true;
    patches = [ ./patches/gnutls-e_again.patch ];
  };

  emacs-26-3 = pkgs.callPackage ./emacs.nix {
    inherit (release "26.3" "14bm73758w6ydxlvckfy9nby015p20lh2yvl6pnrjz0k93h4giq9") name src;
    withAutoReconf = true;
  };

  emacs-snapshot = pkgs.callPackage ./emacs.nix {
    name = "emacs-snapshot";
    src = sources.emacs-snapshot;
    srcRepo = true;
    withAutoReconf = true;
  };
}
