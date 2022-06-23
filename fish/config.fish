if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cdr='cd $HOME/repos'
alias ll='ls -lah $argv'

function check_link_print -d "Check if a symlink exists and that it points at something"
    if test -L $argv
        if test -e $argv
            echo "Good Link"
        else
            echo "Bad Link"
        end
    else if test -e $argv
        echo "No link just a file"
    else
        echo "No link or file"
    end
end

