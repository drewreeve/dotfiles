abbr -a e $EDITOR

if type -q bat
  abbr -a cat bat
end

# Ansible
abbr -a ave --set-cursor ansible-vault encrypt_string --stdin-name "\"%\"" 
abbr -a avr --set-cursor ansible localhost -m debug -a var="\"%\""

# Mise
abbr -a mr --set-cursor mise run %
