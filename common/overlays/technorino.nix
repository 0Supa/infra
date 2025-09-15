final: prev: {
  technorino = prev.chatterino7.overrideAttrs (oldAttrs: {
    pname = "technorino";
    version = "nightly";

    buildInputs =
      oldAttrs.buildInputs
      ++ (with prev; [
        kdePackages.qtimageformats
        libnotify
      ]);
    src = final.chatterino7.src.override {
      owner = "2547techno";
      repo = "technorino";
      tag = null;
      rev = "57f37a716a250edb16ad0c6eefbdf648810e1bc3";
      hash = "sha256-R1AsGyrumSpKv8TyBNalb/CEiU1xQeAv3mpKMfSIelY=";
    };
  });
}
