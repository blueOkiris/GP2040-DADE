{ pkgs ? import <nixpkgs> { } }:

with pkgs;
let
    pico-sdk-full = pico-sdk.overrideAttrs (oldAttrs: {
        src = fetchFromGitHub {
        owner = "raspberrypi";
        repo = oldAttrs.pname;
        rev = "1.5.1";
        fetchSubmodules = true;
        sha256 = "sha256-GY5jjJzaENL3ftuU5KpEZAmEZgyFRtLwGVg3W1e/4Ho=";
    };});
in mkShell {
    buildInputs = [
        cmake
        gcc-arm-embedded
        git
        pico-sdk-full
        protobuf
        (python3.withPackages(ps: with ps; [ nanopb ]))
    ];
    shellHook = ''
        export PICO_SDK_PATH="${pico-sdk-full}/lib/pico-sdk"
    '';
}

