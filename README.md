# moonhabit
Command-line habit tracker based on the "don't break the chain" method. Work in progress.

### Requirements
Lua >= 5.1

lua-cjson

You can use LuaRocks to install lua-cjson.
```shell
luarocks install lua-cjson
```

### Installation
Clone the repository into somewhere convenient and make moonhabit executable.
```shell
cd ~/bin/
git clone https://github.com/owenoclee/moonhabit.git
cd moonhabit
chmod +x moonhabit
```

You may also want to add the repository directory to your PATH so that you can
use moonhabit from anywhere in the terminal.
```shell
PATH=$PATH:~/bin/moonhabit
```

### Usage
Adding a new habit.
```shell
moonhabit add running
```

Checking it off after going for a run.
```shell
moonhabit check running
```

List habits and see their status.
```shell
moonhabit ls
```

Deleting a habit.
```shell
moonhabit rm running
```

