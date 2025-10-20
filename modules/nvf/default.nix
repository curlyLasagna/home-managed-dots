{
    ...
}:
{

programs.nvf = {
    enable = true;
    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
        vim = {
            viAlias = false;
            vimAlias = true;

            lsp = {
                enable = true;
            };

            binds.whichkey = {
                enable = true;
            };
        };
    };
  };
}