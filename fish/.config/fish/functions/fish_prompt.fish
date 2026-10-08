function fish_prompt --description "Write out the prompt"
    # Capture before running anything else, as every command overwrites it
    set -l last_status $status

    echo

    # user@host when connected over SSH
    if set -q SSH_CONNECTION; or fish_is_root_user
        set_color --bold yellow
        fish_is_root_user; and set_color red
        echo -n $USER
        set_color yellow
        set -q SSH_CONNECTION; and echo -n @(prompt_hostname)
        set_color normal
        echo -n ' in '
    end

    # Full path with $HOME abbreviated to ~
    set_color --bold cyan
    echo -n (prompt_pwd --dir-length 0)
    set_color normal

    __fish_prompt_git

    # Duration of the last command, if it took long enough to be interesting
    if test "$CMD_DURATION" -ge 2000
        set -l secs (math --scale 0 $CMD_DURATION / 1000)
        set -l duration (math $secs % 60)s
        test $secs -ge 60; and set duration (math --scale 0 $secs % 3600 / 60)m$duration
        test $secs -ge 3600; and set duration (math --scale 0 $secs / 3600)h$duration
        set_color --bold yellow
        echo -n " $duration"
        set_color normal
    end

    echo
    if test $last_status -ne 0
        set_color red
    else
        set_color magenta
    end
    echo -n '❯ '
    set_color normal
end

# Git info: branch, * for unstaged changes, + for staged changes, 
# ? for untracked files, an in-progress action such as a rebase,
# ⇣⇡ when behind/ahead of upstream and ≡ when stashed
function __fish_prompt_git
    # Fails outside a repo, and inside .git where --show-toplevel is an error
    set -l git_dir (command git rev-parse --show-toplevel --absolute-git-dir 2>/dev/null)[2]
    or return

    set -l branch dirty staged untracked arrows stash

    for line in (command git --no-optional-locks status --porcelain=v2 --branch --show-stash 2>/dev/null)
        switch $line
            case '# branch.oid *'
                # Comes before branch.head, so shows when HEAD is detached
                set branch (string sub --length 7 (string split --fields 3 ' ' -- $line))
            case '# branch.head (detached)'
            case '# branch.head *'
                set branch (string split --fields 3 ' ' -- $line)
            case '# branch.ab *'
                # Line is "# branch.ab +<ahead> -<behind>"
                string match --quiet '* -0' -- $line; or set arrows "$arrows⇣"
                string match --quiet '* +0 *' -- $line; or set arrows "$arrows⇡"
            case '# stash *'
                set stash ≡
            case '#*'
            case '? *'
                set untracked '?'
                break
            case 'u *'
                # Unmerged (conflicted) file. Its XY is never ., so the general
                # case below would wrongly mark it as staged too
                set dirty '*'
            case '*'
                # Changed file: "1 XY ..." or "2 XY ..." where X is the staged
                # status, Y the unstaged one, and . means unchanged
                test (string sub --start 3 --length 1 -- $line) = .; or set staged +
                test (string sub --start 4 --length 1 -- $line) = .; or set dirty '*'
        end
    end

    set -l action (fish_print_git_action $git_dir)

    set_color --bold magenta
    echo -n "  "\uf418" $branch"
    set_color red
    echo -n "$dirty$staged$untracked$arrows"
    test -n "$action"; and set_color yellow; and echo -n " $action"
    test -n "$stash"; and set_color cyan; and echo -n " $stash"
    set_color normal
end
