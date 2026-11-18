local err = function()
vim.log.levels.TRACE = 0
vim.log.levels.DEBUG = 1
vim.log.levels.INFO  = 2
vim.log.levels.WARN  = 3
vim.log.levels.ERROR = 4
vim.log.levels.OFF   = 5
  
end
  return err



Log / Message Level | Message Highlight Group	| Diagnostic / Syntax Counterpart


ERROR	ErrorMsg	DiagnosticError
WARN	WarningMsg	DiagnosticWarn
INFO	InfoMsg	DiagnosticInfo
HINT	HintMsg(custom)	DiagnosticHint
DEBUG	DebugMsg(custom)	DiagnosticHint or Debug
OK/SUCCESS	OkMsg (custom)	DiagnosticOk
