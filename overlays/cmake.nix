final: prev: {
  cmake = prev.cmake.overrideAttrs (oldAttrs: rec {
    patches = oldAttrs.patches ++ [
      (prev.fetchpatch {
        name = "do_not_fail_generation_for_separate_namelink.patch";
        url = "https://gitlab.kitware.com/cmake/cmake/-/merge_requests/5556.patch";
        sha256 = "sha256-TGJyXLPap6Ev7uLFH5biTIrL3T9jGfL1VhV6lbkx2Z8=";
      })
    ];
  });
}
