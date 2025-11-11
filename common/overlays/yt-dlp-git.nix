inputs: final: prev: {
  yt-dlp-git = prev.yt-dlp.overrideAttrs (oldAttrs: {
    version = "git-${inputs.yt-dlp-git.rev or "dirty"}";
    src = inputs.yt-dlp-git;
  });
}
