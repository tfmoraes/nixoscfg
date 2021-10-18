{ config, pkgs, inputs, ... }:

let
  cpkgs = import inputs.colen_nixpkgs {
    config = {
      allowUnfree = true;
    };
    system = "x86_64-linux";
  };
in
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      package = cpkgs.linuxPackages_latest.nvidia_x11_beta;
      # package = config.boot.kernelPackages.nvidiaPackages.beta.overrideAttrs (old: rec {
      #   libPath = old.libPath + ":" + pkgs.lib.makeLibraryPath [
      #     pkgs.wayland
      #     pkgs.mesa
      #   ];
      # }
      # );
      modesetting.enable = true;
      # nvidiaPersistenced = false;
    };
    opengl = {
      extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
    };
  };
  systemd.enableUnifiedCgroupHierarchy = false;
  environment.etc."egl/egl_external_platform.d/10_nvidia_wayland.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so"
        }
    }
  '';

  environment.etc."egl/egl_external_platform.d/15_nvidia_gbm.json".text = ''
      {
        "file_format_version" : "1.0.0",
        "ICD" : {
            "library_path" : "/run/opengl-driver/lib/libnvidia-egl-gbm.so"
        }
    }
  '';

  environment.etc."glvnd/egl_vendor.d/10_nvidia.json".text = ''
    {
      "file_format_version" : "1.0.0",
      "ICD" : {
        "library_path" : "/run/opengl-driver/lib/libEGL_nvidia.so"
      }
    }
  '';
}
