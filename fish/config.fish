#! /usr/bin/fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    function sshagent_findsockets
        find /tmp -uid (id -u) -type s -name agent.\* 2>/dev/null
    end

    function sshagent_testsocket
        if [ ! -x (command which ssh-add) ] ;
            echo "ssh-add is not available; agent testing aborted"
            return 1
        end

        if [ X"$argv[1]" != X ] ;
        set -xg SSH_AUTH_SOCK $argv[1]
        end

        if [ X"$SSH_AUTH_SOCK" = X ]
        return 2
        end

        if [ -S $SSH_AUTH_SOCK ] ;
            ssh-add -l > /dev/null
            if [ $status = 2 ] ;
                echo "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
                rm -f $SSH_AUTH_SOCK
                return 4
            else ;
                echo "Found ssh-agent $SSH_AUTH_SOCK"
                return 0
            end
        else ;
            echo "$SSH_AUTH_SOCK is not a socket!"
            return 3
        end
    end

    function ssh_agent_init
        # ssh agent sockets can be attached to a ssh daemon process or an
        # ssh-agent process.

        set -l AGENTFOUND 0

        # Attempt to find and use the ssh-agent in the current environment
        if sshagent_testsocket ;
            set AGENTFOUND 1
        end

        # If there is no agent in the environment, search /tmp for
        # possible agents to reuse before starting a fresh ssh-agent
        # process.
        if [ $AGENTFOUND = 0 ];
            for agentsocket in (sshagent_findsockets)
                if [ $AGENTFOUND != 0 ] ;
                    break
                end
                if sshagent_testsocket $agentsocket ;
               set AGENTFOUND 1
            end

            end
        end

        # If at this point we still haven't located an agent, it's time to
        # start a new one
        if [ $AGENTFOUND = 0 ] ;
        echo need to start a new agent
        eval (ssh-agent -c)
        end

        # Finally, show what keys are currently in the agent
        # ssh-add -l
    end

    ssh_agent_init
end

alias cdr='cd $HOME/repos'
alias ll='ls -lah $argv'

#if the editor is not resetting you may need to add:
#   Defaults    env_keep += "EDITOR VISUAL" to the sudoers file(sudo visudo)
set -Ux EDITOR /usr/bin/nvim
set -Ux VISUAL /usr/bin/nvim

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

function g_clone -d "Use 1pass creds to clone repo from sloth-ninja"
    set -fx PAT (string replace -a '"' '' \
        (op item get Sloth-PAT --format=json | jq '.fields[] | select(.label == "password") | .value') \
    )

    set -fx encoded (printf "%s"":$PAT" | base64)
    set -fx branch_name (git branch --show-current)
    git -c http.ExtraHeader="Authorization: Basic $encoded" clone $argv 
end

function g_push -d "Change the remote URL. Push changes to repo. Change url back"
    set -fx PAT (string replace -a '"' '' \
        (op item get Sloth-PAT --format=json | jq '.fields[] | select(.label == "password") | .value') \
    )

    set -fx encoded (printf "%s"":$PAT" | base64)
    set -fx branch_name (git branch --show-current)
    git -c http.ExtraHeader="Authorization: Basic $encoded" push origin $branch_name 
end


function newdevsession -d "Create a new tmux session with parent directory as the session name"
    set -fx SESSIONNAME (string split -r -m1 -f2 '/' $PWD)
    echo "Entering: $SESSIONNAME"
    tmux new -s $SESSIONNAME || tmux att -t $SESSIONNAME
end
