# shellcheck disable=all
# https://github.com/zdharma-continuum/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if (($+commands[bat])); then
  # ignore $@ to make `-help foobar` work
  function -help() {
    if [[ -n "$HELP_PAGER" ]]; then 
      if [[ $COLOR == "0" ]]; then
        command cat | $(echo "$HELP_PAGER")
      elif [[ $COLOR == "1" ]]; then
        bat -pplhelp | $(echo "$HELP_PAGER") 
      else
        bat -pplhelp --color=always | $(echo "$HELP_PAGER") 
      fi
    else
      if [[ $COLOR == "0" ]]; then
        command cat
      elif [[ $COLOR == "1" ]]; then
        bat -pplhelp
      else
        bat -pplhelp --color=always
      fi
    fi
  }

  function -help-alias() {
    for opt in $@; do
      alias -g -- "$opt=\\$opt | -help"
    done
  }

  -help-alias --help
  # man
  -help-alias '-\?'
  # ccstudio
  -help-alias -ccs.help
  # x264
  -help-alias --longhelp --fullhelp
  # gnome
  -help-alias --help-all --help-gapplication --help-gtk

  unfunction -- -help-alias
fi
