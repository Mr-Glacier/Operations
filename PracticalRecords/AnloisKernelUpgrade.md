# ⚠️ Anolis 服务器内核漏洞修复方案（离线环境）
<img width="690" height="165" alt="image" src="https://github.com/user-attachments/assets/08991be2-d233-4faf-8161-4b2b4cf6244d" />
## 背景说明

- 线上服务器存在系统内核漏洞（如：CVE-2022-1586）
- 官方提供了升级命令，但服务器 **无外网连接**，无法直接执行

---

## ✅ 解决方案

### 步骤一：构建线下虚拟环境

在本地虚拟机中搭建和线上一致的系统环境：

- 操作系统：Anolis OS 8.4 
- 网络：可访问公网

---

### 步骤二：下载升级所需 RPM 包

以下命令在本地虚拟机中执行，用于收集离线安装所需的所有 RPM 包：

#### 下载 pcre2 包（修复 CVE-2022-1586）
```bash
dnf install -y --downloadonly --downloaddir=/zkzd/pcre2 pcre2
```

#### 下载 openssl 相关包
```bash
dnf install -y --downloadonly --downloaddir=./deps openssl openssl-libs
```

#### 下载内核及相关工具包
```bash
dnf install -y --downloadonly --downloaddir=/zkzd/offline \
  kernel-tools \
  python3-perf \
  kernel-core \
  kernel-headers \
  kernel-tools-libs \
  kernel \
  kernel-devel \
  kernel-modules \
  bpftool \
  perf
```

#### 检查 CVE 修复记录
```bash
rpm -q --changelog -p pcre2-10.32-3.0.1.an8_6.aarch64.rpm | grep -i 'CVE-2022-1586'
rpm -q --changelog openssl | grep -i 'CVE-2022'
```

#### 其他依赖包下载(用于升级内核)
```bash
dnf download --destdir=./deps linux-firmware-20250325-129.git710a336b.an8.noarch
dnf download --destdir=./deps libbabeltrace opencsd traceevent
```

---

### 步骤三：将 RPM 包传输至线上服务器

这些安装包打成tar包传输到离线服务器

---

### 步骤四：在无网环境中执行安装

#### 升级 pcre2
```bash
rpm -Uvh /zkzd/pcre2/pcre2-*.rpm
rpm -qp --changelog /zkzd/pcre2/pcre2-*.rpm | grep -Ei 'CVE-2022-1586'
```

#### 升级 openssl && openssl-libs
```bash
rpm -Uvh /zkzd/openssl/openssl-*.rpm
rpm -qp --changelog /zkzd/openssl/openssl-*.rpm | grep -Ei 'CVE-2022-2097|CVE-2022-1292|CVE-2022-2068
```

#### 升级 内核以及相关工具
```bash
// 更新内核前,需要先安装 firmware
rpm -Uvh  linux-firmware-20250325-129.git710a336b.an8.noarch
// 更新内核(添加而不是覆盖)
rpm -ivh kernel-*.rpm
// 查看可用的内核选择
grubby --info=ALL | grep ^kernel
// 设置为我们更新的内核版本为默认版本
grubby --set-default /boot/vmlinuz-4.18.0-553.58.1.0.1.an8.aarch64
// 验证设置
grubby --default-kernel
```
---
### 步骤五：重启系统生效（如升级了内核）

```bash
reboot
```
---
