self: super: {
  paraview_without_python = super.paraview.overrideAttrs (old: rec{
    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DPARAVIEW_ENABLE_FFMPEG=ON"
      "-DPARAVIEW_ENABLE_GDAL=ON"
      "-DPARAVIEW_ENABLE_MOTIONFX=ON"
      "-DPARAVIEW_ENABLE_VISITBRIDGE=ON"
      "-DPARAVIEW_ENABLE_XDMF3=ON"
      "-DPARAVIEW_INSTALL_DEVELOPMENT_FILES=ON"
      "-DPARAVIEW_USE_MPI=ON"
      "-DPARAVIEW_USE_PYTHON=OFF"
      "-DVTK_SMP_IMPLEMENTATION_TYPE=TBB"
      "-DVTKm_ENABLE_MPI=ON"
      "-DCMAKE_INSTALL_LIBDIR=lib"
      "-DCMAKE_INSTALL_INCLUDEDIR=include"
      "-DCMAKE_INSTALL_BINDIR=bin"
      "-DOpenGL_GL_PREFERENCE=GLVND"
      "-GNinja"
    ];
  });
}
