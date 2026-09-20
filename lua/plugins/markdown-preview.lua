-- markdown-preview.nvim: build with the Node app instead of the prebuilt
-- binary. LazyVim's default build downloads a release binary via
-- mkdp#util#install(); on macOS arm64 that came down corrupt (128 KB instead
-- of ~18 MB) and failed with "Unknown system error -88". Without app/bin the
-- plugin falls back to running app/index.js with node, which is already
-- present for vtsls and friends.
return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && rm -rf bin && npm install --no-fund --no-audit",
}
