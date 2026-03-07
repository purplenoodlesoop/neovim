{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.nvim-silicon ];

  extraConfigLua = ''
    require("silicon").setup({
      output = function()
        return "~/silicon-" .. os.date("!%Y-%m-%dT%H:%M:%S") .. ".png"
      end,
      background = "#FFFFFF",
      shadow_blur_radius = 0,
      shadow_offset_x = 0,
      shadow_offset_y = 0,
      pad_horiz = 80,
      pad_vert = 100,
      line_number = true,
      round_corner = true,
    })
  '';
}
