# Default target
all: clone build

# Target to clone the nixpkgs repository
clone:
	@if [ ! -d "$(PWD)/nixpkgs" ]; then \
		git clone --depth=1 -b release-23.05 https://github.com/NixOS/nixpkgs; \
	else \
		echo "nixpkgs repository already exists in $(PWD)/nixpkgs"; \
	fi

# Target to run nix-build
build:
	nix-build -A config.system.build.sdImage \
		--option system aarch64-linux \
		--option sandbox false \
		-I nixos-config=$(PWD)/sd-image.nix \
		-I nixpkgs=$(PWD)/nixpkgs \
		$(PWD)/nixpkgs/nixos/default.nix

# Phony targets
.PHONY: all clone build
