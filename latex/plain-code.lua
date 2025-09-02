function CodeBlock(el)
  local verbatim = pandoc.RawBlock('latex', '\\begin{verbatim}\n' .. el.text .. '\n\\end{verbatim}')
  return verbatim
end