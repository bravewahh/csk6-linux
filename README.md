# csk6-linux

## 概述

支持csk6使用linux、u-boot以及romfs一键打包编译运行

## 仓库更新

```
git clone https://github.com/bravewahh/csk6-linux.git

make update
```
## 编译

### 编译所有目标
```
make build  
```
编译结果在build/images目录下。

### 清除
```
make distclean
```

## 烧录

```
make flash
```

