:: use this file to run your own startup commands 
:: use @ in front of the command to prevent printing the command
@set LANG=en_US.UTF-8
@set LC_ALL=en_US.UTF-8
@set LANGUAGE=en_US.UTF-8
@set MSYS=winsymlinks:nativestrict
@set PATH=%PATH%;C:\Dev\msys64\mingw64\bin;C:\Dev\msys64\usr\bin


@prompt $e[0m( %username%@%userdomain%:$e[1;34m$p$e[0m $e[35m{git}{hg}$e[0m )$_$+{lamb} 
@chcp 65001 >nul