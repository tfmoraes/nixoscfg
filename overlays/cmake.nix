final: prev: {
  cmake = prev.cmake.overrideAttrs (oldAttrs: rec {
    patches = oldAttrs.patches ++ [
      (fetchpatch {
        name = "do_not_fail_generation_for_separate_namelink.patch";
        url = "https://gitlab.kitware.com/cmake/cmake/-/merge_requests/5556.patch";
        sha256 = "061f1lcm72glksf475ikl8w10pnbgqa7049ylw06nikis2qdjlfq";
      })
    ];
  });
}
