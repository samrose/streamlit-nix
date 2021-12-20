{ pkgs ? import ./nixpkgs.nix {} }:
with pkgs;
let
  mach-nix = import (builtins.fetchGit {
    url = "https://github.com/DavHau/mach-nix";
    ref = "refs/tags/3.3.0";
  }) {
    # optionally bring your own nixpkgs
    # pkgs = import <nixpkgs> {};

    # optionally specify the python version
    python = "python39";

    # optionally update pypi data revision from https://github.com/DavHau/pypi-deps-db
    pypiDataRev = "65f1eac8364c73759b5f3dbddff4e2f61441c5b2";
    pypiDataSha256 = "063bqj6i29285y2pyii9r8rn2sf5kddxa8lf83jllxhqd8pmis9i";
  };
in
mach-nix.mkPythonShell {  # replace with mkPythonShell if shell is wanted
  requirements = builtins.readFile ./requirements.txt;
  # based on solution discussed at https://github.com/DavHau/mach-nix/issues/318#issuecomment-914261715
  _.gitpython.propagatedBuildInputs.mod = pySelf: self: oldVal: oldVal ++ [ pySelf.typing-extensions ];
}
