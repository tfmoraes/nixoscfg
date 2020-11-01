self: super: {
  # multipath-tools = super.multipath-tools.overrideDerivation (oldAttrs: rec{
    # postPatch = ''
      # substituteInPlace libmultipath/Makefile --replace /usr/include/libdevmapper.h ${super.stdenv.lib.getDev super.lvm2}/include/libdevmapper.h
      # sed -i -re '
      # s,^( *#define +DEFAULT_MULTIPATHDIR\>).*,\1 "'"$out/lib/multipath"'",
      # ' libmultipath/defaults.h
      # sed -i -e 's,\$(DESTDIR)/\(usr/\)\?,$(prefix)/,g' \
      # kpartx/Makefile libmpathpersist/Makefile
      # sed -i -e "s,GZIP,GZ," \
      # $(find * -name Makefile\*)
    # '';
  # });
}
