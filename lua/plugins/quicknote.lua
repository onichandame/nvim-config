local qn = require('quicknote')
vim.keymap.set('n', 'qnn', qn.OpenNoteAtCurrentLine, {})
vim.keymap.set('n', 'qnc', qn.NewNoteAtCurrentLine, {})
vim.keymap.set('n', 'qnd', qn.DeleteNoteAtCurrentLine, {})
