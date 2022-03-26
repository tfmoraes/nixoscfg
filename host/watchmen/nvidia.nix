{ config, pkgs, inputs, ... }:
let
  cpkgs = import inputs.jonringer_npkgs {
    config = {
      allowUnfree = true;
    };
    system = "x86_64-linux";
  };
in
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    deviceSection = ''
      Option "Coolbits" "28"
    '';
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # package = cpkgs.linuxPackages_latest.nvidia_x11_beta;
      modesetting.enable = true;
      # nvidiaPersistenced = false;
    };
    opengl = {
      # extraPackages = with pkgs; [
      #   libvdpau-va-gl
      #   vaapiVdpau
      #   # (pkgs.runCommand "nvidia-icd" { } ''
      #   #   mkdir -p $out/share/vulkan/icd.d
      #   #   cp ${pkgs.linuxPackages.nvidia_x11}/share/vulkan/icd.d/nvidia_icd.x86_64.json $out/share/vulkan/icd.d/nvidia_icd.json
      #   # '')
      # ];
      # extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
    };
  };
  systemd.enableUnifiedCgroupHierarchy = false;

  # environment.etc."egl/egl_external_platform.d/01_nvidia_wayland.json".text = ''
  #     {
  #       "file_format_version" : "1.0.0",
  #       "ICD" : {
  #           "library_path" : "${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so"
  #       }
  #   }
  # '';

  # environment.etc."egl/egl_external_platform.d/10_nvidia_wayland.json".text = ''
  #     {
  #       "file_format_version" : "1.0.0",
  #       "ICD" : {
  #           "library_path" : "/run/opengl-driver/lib/libnvidia-egl-wayland.so"
  #       }
  #   }
  # '';

  # environment.etc."egl/egl_external_platform.d/15_nvidia_gbm.json".text = ''
  #     {
  #       "file_format_version" : "1.0.0",
  #       "ICD" : {
  #           "library_path" : "/run/opengl-driver/lib/libnvidia-egl-gbm.so"
  #       }
  #   }
  # '';

  # environment.etc."glvnd/egl_vendor.d/10_nvidia.json".text = ''
  #   {
  #     "file_format_version" : "1.0.0",
  #     "ICD" : {
  #       "library_path" : "/run/opengl-driver/lib/libEGL_nvidia.so"
  #     }
  #   }
  # '';

  # environment.etc."OpenCL/vendors/nvidia.icd".source = "${nvidia_pkg}/etc/OpenCL/vendors/nvidia.icd";

  # environment.etc."gbm/nvidia-drm_gbm.so".source = "${nvidia_pkg}/lib/libnvidia-allocator.so";

  environment.variables = {
    # "GBM_BACKENDS_PATH" = "/run/opengl-driver/lib/gbm";
    # "GBM_BACKEND" = "nvidia-drm";
    # "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    # "OCL_ICD_VENDORS" = "/run/opengl-driver/etc/OpenCL/vendors";
  };
}
