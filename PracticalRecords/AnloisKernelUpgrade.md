<img width="690" height="165" alt="image" src="https://github.com/user-attachments/assets/08991be2-d233-4faf-8161-4b2b4cf6244d" />
线上服务器被扫除系统内核版本的漏洞,同时给出了升级建议命令
登录上服务器,运行GG
ping www.baidu.com 不通
不是啊喂,没网给我这个命令干什么

1. 构建线下虚拟环境 Anlois os 8.4
2. 在虚拟环境下执行升级命令
   yum reinstall --downloadonly --downloaddir=/zkzd/pcre2 pcre2
   dnf install -y --downloadonly --downloaddir=./deps openssl openssl-libs
   yum reinstall --downloadonly --downloaddir=/zkzd/offline kernel-tools python3-perf kernel-core kernel-headers kernel-tools-libs kernel kernel-devel kernel-modules bpftool perf

   rpm -q --changelog -p pcre2-10.32-3.0.1.an8_6.aarch64.rpm | grep -i 'CVE-2022-1586'
   rpm -q --changelog openssl | grep -i 'CVE-2022'
   
3.ss
