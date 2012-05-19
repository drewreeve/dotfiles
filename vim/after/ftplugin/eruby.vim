" use erb tags with surround plugin in any file outside of rails projects
let b:surround_{char2nr('=')} = "<%= \r %>"
let b:surround_{char2nr('-')} = "<% \r %>"
let b:surround_{char2nr('#')} = "<%# \r %>"