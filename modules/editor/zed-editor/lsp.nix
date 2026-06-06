{
  lsp = {
    nixd = {
      settings = {
        diagnostic = {
          suppress = [ "sema-extra-with" ];
        };
      };
    };
    vtsls = {
      settings = {
        typescript.updateImportsOnFileMove.enabled = "always";
        javascript.updateImportsOnFileMove.enabled = "always";
      };
      enable_lsp_tasks = true;
    };

    tinymist.settings = {
      exportPdf = "onSave";
      outputPath = "$root/$name";
    };
  };
}
