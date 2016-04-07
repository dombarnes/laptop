# Add any auto-loaded Atom code on init here.
path = require 'path'

atom.workspace.getActiveTextEditor (editorView) ->
  editor = editorView
  if path.extname(editor.getPath()) is '.md'
    editor.setSoftWrap(true)
