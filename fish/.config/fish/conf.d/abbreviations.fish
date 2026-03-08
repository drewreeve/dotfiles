abbr -a e $EDITOR

if type -q bat
    abbr -a cat bat
end

# Ansible
abbr -a ave --set-cursor ansible-vault encrypt_string --stdin-name "\"%\""
abbr -a avr --set-cursor ansible localhost -m debug -a var="\"%\""

# Git
abbr -a g git
abbr -a gc git commit
abbr -a gp git push
abbr -a gpl git push --force-with-lease
abbr -a gd git diff

# Mise
abbr -a mr --set-cursor mise run %
