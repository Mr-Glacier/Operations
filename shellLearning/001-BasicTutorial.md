### 1. Shell 环境介绍

**定义**：Shell 是一个命令行解释器。它接收用户（或脚本）输入的命令，将其解析并传递给操作系统内核执行，然后将结果返回给用户。

**作用**：它是用户与操作系统内核之间的接口。虽然图形界面（GUI）很直观，但 Shell 提供了更强大、更灵活、更高效的控制能力，尤其适合自动化任务、系统管理、软件开发和服务器操作。

**类型**：
- **Bourne Shell (sh)**：早期的 Unix Shell，是许多现代 Shell 的基础。
- **Bash (Bourne-Again SHell)**：由 GNU 项目开发，是 `sh` 的增强版，功能更丰富。它是绝大多数 Linux 发行版和 macOS（较旧版本）的默认 Shell。Bash 兼容 sh。
- **Zsh (Z Shell)**：基于 `sh` 和 `ksh`（KornShell）开发，集成了许多现代特性，通常被认为是 Bash 的“超集”或“进化版”。它以其强大的自动补全、主题支持和高度可定制性而闻名。macOS 从 Catalina (10.15) 开始将 Zsh 设为默认 Shell。

---

### 2. 基础命令

#### 2.1 `ls` — 列出目录内容
**用法**： `ls [选项] [目录]`
```shell
ls        # 列出当前目录内容
ls -l     # 列出详细信息（权限、所有者、大小、修改时间）
ls -a     # 包括隐藏文件（以 . 开头）
ls -lt    # 按修改时间排序（最新在前）
```

#### 2.2 `cd` — 改变目录
**用法**： `cd [目录路径]`
```shell
cd /home/user  # 切换到指定绝对路径
cd ..          # 返回上级目录
cd ~           # 返回用户主目录
cd -           # 切换到上一次所在的目录
```

#### 2.3 `cp` — 复制文件或目录
**用法**： `cp [选项] [源] [目标]`
```shell
cp file1.txt file2.txt    # 复制文件
cp file.txt /new/dir/     # 复制文件到目录
cp -r dir1/ dir2/         # 递归复制整个目录
```

#### 2.4 `mv` — 移动或重命名文件
**用法**： `mv [源] [目标]`
```shell
mv file1.txt file2.txt    # 重命名文件
mv file.txt /new/dir/     # 移动文件到目录
mv dir1/ dir2/            # 移动/重命名目录
```

#### 2.5 `rm` — 删除文件或目录
**用法**： `rm [选项] [文件或目录]`
```shell
rm file.txt       # 删除文件
rm -r dir/        # 递归删除目录及其内容
rm -f file.txt    # 强制删除，不提示确认
rm -rf dir/       # 强制递归删除目录（⚠️ 危险操作！）
```

#### 2.6 `mkdir` — 创建目录
**用法**： `mkdir [选项] [目录名]`
```shell
mkdir new_folder          # 创建单个目录
mkdir -p path/to/new_dir  # 创建多级目录（父目录不存在时自动创建）
```

---

### 3. 文件操作

#### 3.1 `cat` — 查看文件内容
**用法**： `cat [文件名]`
```shell
cat file.txt               # 显示文件全部内容
cat file1.txt file2.txt    # 连接并显示多个文件内容
```

#### 3.2 `grep` — 查找文件中的字符串
**用法**： `grep [选项] [模式] [文件]`
```shell
grep 'text' file.txt       # 查找文件中包含 'text' 的行
grep -i 'Text' file.txt    # 忽略大小写查找
grep -r 'text' .           # 在当前目录及子目录中递归查找
grep -n 'text' file.txt    # 显示匹配行的行号
```

#### 3.3 `sed` — 流编辑器，修改文件内容
**用法**： `sed 's/old/new/[g]' [文件]`
```shell
sed 's/foo/bar/' file.txt     # 替换每行中第一个 'foo' 为 'bar'
sed 's/foo/bar/g' file.txt    # 替换每行中所有 'foo' 为 'bar' (g = global)
sed -i 's/foo/bar/g' file.txt # 直接修改原文件 (-i = in-place)
```

#### 3.4 `awk` — 文本处理工具
**用法**： `awk '{动作}' [文件]`
```shell
awk '{print $1}' file.txt       # 打印每行的第一个字段（默认以空格分隔）
awk -F',' '{print $2}' file.csv  # 使用逗号作为分隔符，打印第二列
awk '$1 > 100 {print $0}' data.txt # 打印第一列数值大于100的整行
```

---

### 4. 权限管理

#### 4.1 `chmod` — 更改文件或目录权限
**用法**： `chmod [权限] [文件或目录]`
```shell
chmod +x script.sh          # 为文件添加执行权限
chmod u+x script.sh         # 仅用户（所有者）添加执行权限
chmod 755 file.txt          # 设置权限为 rwxr-xr-x (数字模式)
chmod 644 document.txt      # 设置权限为 rw-r--r-- 
```

#### 4.2 `chown` — 更改文件或目录的所有者和组
**用法**： `chown [所有者][:组] [文件或目录]`
```shell
chown user file.txt         # 将文件所有者更改为 user
chown user:group file.txt   # 将文件所有者改为 user，组改为 group
chown -R user:group dir/   # 递归更改目录及其内容的所有者和组
```

#### 4.3 `sudo` — 以超级用户权限执行命令
**用法**： `sudo [命令]`
```shell
sudo apt update             # 更新软件包列表（需要管理员权限）
sudo systemctl restart nginx # 重启服务
sudo -i                     # 切换到 root 用户的 shell
```

---

### 5. 输入输出重定向与管道

#### 5.1 输入输出重定向
| 操作符 | 说明 |
| :--- | :--- |
| `>` | 将命令输出**覆盖**写入文件 |
| `>>` | 将命令输出**追加**到文件末尾 |
| `<` | 将文件内容作为命令的输入 |
| `2>` | 将错误输出重定向到文件 |

**示例**：
```shell
echo "Hello, World!" > output.txt    # 覆盖写入
echo "More text" >> output.txt       # 追加写入
sort < input.txt > sorted.txt        # 从文件读取输入，结果写入另一文件
command > output.log 2>&1            # 将标准输出和错误输出都重定向到同一文件
```

#### 5.2 管道 (`|`)
**用法**： `command1 | command2`
将 `command1` 的**标准输出**作为 `command2` 的**标准输入**。
```shell
cat file.txt | grep "pattern" | wc -l  # 查找包含 'pattern' 的行数
ps aux | grep nginx                    # 查找包含 'nginx' 的进程
ls -l | head -5                        # 显示前5个文件的详细信息
```

---

### 6. 环境变量与 Shell 变量

#### 6.1 环境变量
影响整个进程环境的变量。常见变量：
- `$PATH`：可执行程序的搜索路径。
- `$HOME`：用户主目录。
- `$USER`：当前用户名。
- `$PWD`：当前工作目录。

**查看**：
```shell
echo $PATH              # 显示 PATH 变量值
env                     # 列出所有环境变量
printenv HOME           # 显示特定环境变量
```

#### 6.2 Shell 变量
在当前 Shell 会话中有效的变量。
```shell
VAR="Hello World"       # 设置变量（注意：等号两边无空格）
echo $VAR               # 引用变量
echo ${VAR}             # 推荐写法（避免歧义）
unset VAR               # 删除变量
```

#### 6.3 永久设置环境变量
将 `export` 命令添加到 Shell 的配置文件中，使其在每次登录时生效。

**Bash**：
```bash
echo 'export MY_VAR="MyValue"' >> ~/.bashrc
source ~/.bashrc        # 立即生效（或重新打开终端）
```

**Zsh**：
```zsh
echo 'export MY_VAR="MyValue"' >> ~/.zshrc
source ~/.zshrc         # 立即生效（或重新打开终端）
```

> **注意**：`export` 使变量成为环境变量，对子进程可见。
