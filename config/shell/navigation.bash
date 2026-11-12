# Source from ~/.bashrc after other completion/prompt setup. No installation.
# See docs/tools/fzf.md. Native fzf bindings are opt-in by sourcing this file.
[[ $- == *i* ]] || return 0

if [[ -z ${__tfd_fzf_loaded:-} ]] && command -v fzf >/dev/null 2>&1; then
    if __tfd_init="$(fzf --bash 2>/dev/null)" && [[ -n $__tfd_init ]]; then
        if eval "$__tfd_init"; then
            __tfd_fzf_loaded=1
        else
            printf '%s\n' 'terminal-first-dev: fzf initialization failed.' >&2
        fi
    else
        printf '%s\n' 'terminal-first-dev: fzf --bash unavailable; update fzf for key bindings. Standalone fzf is unchanged.' >&2
    fi
    unset __tfd_init
fi

# Initialize last; keep the normal cd command and user FZF_* settings unchanged.
if [[ -z ${__tfd_zoxide_loaded:-} ]] && command -v zoxide >/dev/null 2>&1; then
    if __tfd_init="$(zoxide init bash)" && [[ -n $__tfd_init ]]; then
        if eval "$__tfd_init"; then
            __tfd_zoxide_loaded=1
        else
            printf '%s\n' 'terminal-first-dev: zoxide initialization failed.' >&2
        fi
    else
        printf '%s\n' 'terminal-first-dev: zoxide init bash failed; cd is unchanged.' >&2
    fi
    unset __tfd_init
fi
return 0
