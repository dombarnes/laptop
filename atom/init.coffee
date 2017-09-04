# Add any auto-loaded Atom code on init here.
path = require 'path'

# rbenv
process.env.PATH = [process.env.HOME + "/.rbenv/shims", process.env.PATH].join(":")
process.env.PATH = [process.env.HOME + "/.rbenv/bin", process.env.PATH].join(":")

atom.workspace.getActiveTextEditor (editorView) ->
  editor = editorView
  if path.extname(editor.getPath()) is '.md'
    editor.setSoftWrap(true)
