---
title: Git
description: 'Git 学习记录'
publishDate: 2024-04-1 21:33:05
tags: ['git', 'learning']
---

## 什么是 Git？

- **Git** 是一个开源的 **分布式版本控制系统**，用于高效地管理代码版本，适用于任何规模的项目。
- 它由 **Linus Torvalds** 在 2005 年开发，用于协作管理 **Linux 内核** 的代码版本。
- 与传统的集中式版本控制工具（如 **CVS**、**Subversion**）不同，Git 采用分布式架构，使每个开发者的本地仓库都包含完整的历史记录和版本信息。

---

## 初始化 Git 仓库

在项目目录下执行以下命令来初始化一个 Git 仓库：

~~~bash
git init
~~~

> 这会创建一个 `.git` 目录，其中存储了 Git 所需的所有元数据和历史记录。

---

## 克隆远程仓库

若要克隆一个现有的仓库，可以使用以下命令：

~~~bash
# 从本地路径克隆仓库
git clone /path/to/repository

# 从远程服务器克隆仓库
git clone username@host:/path/to/repository

# 从 HTTPS 或 SSH 地址克隆
git clone https://github.com/user/repository.git
~~~

---

## Git 的工作流：三棵树

Git 的工作流由三棵“树”组成：

1. **工作区（Working Directory）**：实际保存你的项目文件。
2. **暂存区（Staging Area / Index）**：临时保存修改的文件，等待提交。
3. **HEAD**：指向当前分支的最新提交记录。

**可视化示意图：**
![Git 三棵树](https://cdn.itmt.io/bed/2025/08/git-workflow.png)

---

## 添加和提交修改

### 添加文件到暂存区

~~~bash
git add <filename>         # 添加指定文件
git add .                  # 添加所有修改的文件
~~~

### 提交修改到仓库

~~~bash
git commit -m "描述你的改动内容"
~~~

> 提交时务必写清楚注释，简洁且易于理解，方便团队协作。

---

## 远程仓库与推送

### 添加远程仓库

将本地仓库与远程仓库关联：

~~~bash
git remote add origin <远程仓库地址>
~~~

### 推送本地修改到远程仓库

~~~bash
git push origin master      # 推送到主分支（master）
git push origin <branch>    # 推送到指定分支
~~~

---

## 分支管理

Git 分支允许你在开发新功能时，与主分支（如 `master`）隔离，避免影响稳定的代码。

### 创建与切换分支

~~~bash
# 创建一个新分支并切换到该分支
git checkout -b feature_x

# 切换回主分支
git checkout master
~~~

### 删除分支

~~~bash
git branch -d feature_x     # 删除本地分支
git push origin --delete feature_x  # 删除远程分支
~~~

### 推送分支到远程

~~~bash
git push origin <branch>
~~~

**分支示意图：**
![分支管理](https://cdn.itmt.io/bed/2025/08/git-branch.png)

---

## 拉取与合并更新

### 更新本地代码（`pull`）

从远程仓库获取最新改动并合并到当前分支：

~~~bash
git pull
~~~

### 合并分支

将其他分支的代码合并到当前分支：

~~~bash
git merge <branch>
~~~

### 查看分支间的差异

在合并前，可以查看分支间的差异：

~~~bash
git diff <source_branch> <target_branch>
~~~

---

## 替换本地修改

### 丢弃工作区的未提交修改

~~~bash
git checkout -- <filename>   # 使用最新提交替换工作区的文件
~~~

### 丢弃所有本地修改（强制重置）

重置本地仓库至远程仓库的最新版本：

~~~bash
git fetch origin
git reset --hard origin/master
~~~

---

## Git 常用操作总结

| 操作             | 命令示例                   | 说明                   |
| ---------------- | -------------------------- | ---------------------- |
| 初始化仓库       | `git init`                 | 初始化本地 Git 仓库    |
| 克隆远程仓库     | `git clone <repo>`         | 克隆远程仓库到本地     |
| 添加修改到暂存区 | `git add <file>`           | 添加文件到暂存区       |
| 提交修改         | `git commit -m "message"`  | 提交修改               |
| 查看当前状态     | `git status`               | 显示工作区和暂存区状态 |
| 查看提交历史     | `git log`                  | 查看提交记录           |
| 创建分支         | `git branch <branch>`      | 创建分支               |
| 切换分支         | `git checkout <branch>`    | 切换到指定分支         |
| 合并分支         | `git merge <branch>`       | 合并分支到当前分支     |
| 推送到远程仓库   | `git push origin <branch>` | 推送本地分支到远程仓库 |
| 拉取远程仓库更新 | `git pull`                 | 拉取远程更新并合并     |
| 删除分支         | `git branch -d <branch>`   | 删除本地分支           |

---

## 常见问题与解决方案

1. **如何撤销上一次提交但保留修改？**
   ~~~bash
   git reset --soft HEAD~1
   ~~~

2. **如何解决合并冲突？**
   - 手动编辑冲突文件，标记合并完成后：
     ~~~bash
     git add <文件名>
     git commit -m "解决冲突"
     ~~~

3. **忘记添加文件后提交了怎么办？**
   ~~~bash
   git add <文件名>
   git commit --amend -m "修改提交信息"
   ~~~

---

## 推荐资源

- **官方文档**： [Pro Git 2nd Edition](https://git-scm.com/book/zh/v2)

---
