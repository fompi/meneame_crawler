{
  description = "Meneame.net crawler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python3;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            (python.withPackages (ps: [
              ps.scrapy
              ps.itemloaders
            ]))
          ];

          shellHook = ''
            echo "meneame_crawler dev shell"
            echo "  Python: $(python3 --version)"
            echo "  Scrapy: $(python3 -c 'import scrapy; print(scrapy.__version__)')"
            echo ""
            echo "Usage: scrapy crawl meneame -a status=portada -s DEPTH_LIMIT=0 -o portada.csv"
          '';
        };
      }
    );
}
