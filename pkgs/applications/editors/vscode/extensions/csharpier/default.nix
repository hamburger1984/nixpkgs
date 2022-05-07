{ lib
, vscode-utils
}:

let
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in
buildVscodeMarketplaceExtension {
  # TODO: how to run dotnet tool install -g csharpier ??
  mktplcRef = {
    publisher = "csharpier";
    name = "csharpier-vscode";
    version = "1.2.3";
    sha256 = "sha256-IbSDDw+DFZZeWIrf2+YVjybEeVFeahQK0e1xziwbq78=";
  };
  meta = with lib; {
    description = "Code formatter using csharpier";
    homepage = "https://marketplace.visualstudio.com/items?itemName=csharpier.csharpier-vscode";
    license = licenses.mit;
  };
}
