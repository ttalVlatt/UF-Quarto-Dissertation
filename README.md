# UF Quarto Dissertation Template

This template is a reworking of [UF's `LaTeX` dissertation template](https://it.ufl.edu/helpdesk/graduate-resources/ms-word--latex-templates/) to work with Quarto (the successor to R markdown).

The process is pretty straight forward

1. Edit the header of `00-dissertation-setup.qmd` to your name, dergeem, title, etc.
2. Edit the contents of the various files in the `/preface/` folder (just type in plain text, no formatting required)
3. Edit the `01-` through `06-` `.qmd` files to your dissertation content as your would write any `.qmd` file
4. Render `00-dissertation-setup.qmd` to produce `dissertation.pdf` combining all files together in line with the UF template

## Tips

- Insert tables as `kable()` using the example code chunks for formatting
  - Ensure all table code chunks are appropriately labeled `#| label: tbl-<something>` with `#| tbl-caption: <a caption>` for a caption and `#| tbl-pos: H`  to try and force placement there
  - Ensure all table code chunks are preceeded by `\realSingleSpace` and followed by `\doublespacing` as they are in the example files
- Insert figures as chunk output or directly as images
  - Ensure all figure code chunks are appropriately labeled `#| label: fig-<something>` with `#| fig-caption: <a caption>` for a caption and `#| fig-pos: H`  to try and force placement there
  - Ensure all figure images are appropriately labeled by adding `{#fig-<something> fig-caption:"<a caption>" fig-pos:H}` after the image markdown
- Don't try to add a header to any of the `01-` through `06-` `.qmd` files, it may cause errors, either render these individual documents without a header to see an `html` preview, or, render `00-dissertation-setup.qmd` to produce the full document `dissertation.pdf` 

## Limitations

- Does not currently handle tables more than one page in length properly
