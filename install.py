import json
import os
import pathlib
import shlex
import subprocess

def install_tools(tool_list):
    for tool in tool_list:
        print(f"Installing {tool}")
        cmd = shlex.split(tool_list.get(tool, ""))
        try:
            retval = subprocess.check_call(cmd)
            print(f"{cmd}\n\treturned {retval}")
        except Exception as e:
            print(f"An error while running {cmd}.\n\t{e}")
        
def add_links(links_list):
    for directory in links_list:
        repo_dir = pathlib.Path(directory).absolute()
        print(f"Dir: {repo_dir}")
        for f in links_list.get(directory, {}):
            repo_file = repo_dir / f
            print(f"File: {repo_file}")
            link_location = pathlib.Path(links_list.get(directory, {}).get(f, '')).expanduser()
            print(f"Link location: {link_location}")
            if link_location.exists():
                link_location.unlink()
            print(f"Should link {link_location} from {repo_file}")
            if not link_location.parent.exists():
                link_location.parent.mkdir(parents=True)
            os.symlink(str(repo_file),str(link_location))

def parse_install(install_file):
    print(f"Opening {install_file}")
    jdata = json.load(open(install_file))
    configurations = jdata.get('Configurations', {})
    installations = jdata.get('installations', {})
    install_tools(installations)
    add_links(configurations)

if __name__ == "__main__":
    install_file = 'locations.json'
    parse_install(install_file)
