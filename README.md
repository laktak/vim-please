# vim-please

Vim plugin that enables communication without +clientserver

```
==============================================================================
INTRODUCTION                                                            *please*

This plugin is a simple client server replacement. At the moment the only
supported command is 'open'.

:Please                                                                *:Please*

    Start the process that listens for commands from clients.

    Clients can use scripts from the scripts folder to open files from
    outside Vim.


==============================================================================
OPTIONS                                                         *please-options*

                                                                 *g:please_port*
The port that is used to communicate with clients. Default: 4048

  let g:please_port = 4048

                                                             *g:please_open_cmd*
The command that is used to open files. Default: 'e'

  let g:please_open_cmd = 'tabe'

==============================================================================
```
