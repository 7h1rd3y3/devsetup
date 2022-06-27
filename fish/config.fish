#! /usr/bin/fish

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

op completion fish | source


function g_push -d "Change the remote URL. Push changes to repo. Change url back"
    set -fx PAT (string replace -a '"' '' \
        (op item get Sloth-PAT --format=json | jq '.fields[] | select(.label == "password") | .value') \
    )

    set -fx encoded (printf "%s"":$PAT" | base64)
    set -fx branch_name (git branch --show-current)
    git -c http.ExtraHeader="Authorization: Basic $encoded" push origin $branch_name 
end
