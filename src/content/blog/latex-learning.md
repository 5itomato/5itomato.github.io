---
title: LateX
description: 'LateX 学习记录'
publishDate: 2025-02-10 21:21:11
tags: ['latex', 'learning']
---

## 什么是 LaTeX ？

1.  打公式方便？
「复杂公式输入哪家强，当然首选 LaTEX 帮忙」
2. 写论文神器？
「想要轻松给论文排版，当然少不了 LaTEX 啦」
3. 不想做宏编程的标记语言不是好的排版引擎？

LaTEX is a high-quality typesetting system; it includes features designed for the production of technical and scientific documentation. LaTEX is the de facto standard for the communication and publication of scientific documents. LaTEX is available as free software.

> ——What you think is what you get!

Berkeley 计算机系教授 Christos Papadimitriou 曾说过一句半开玩笑的话：

> Every time I read a LaTeX document, I think, wow, this must be correct!

---

## 一、安装 LaTeX 环境

###  **选择发行版（必备工具包）**

- **TeX Live**（跨平台，推荐）
  下载地址：https://www.tug.org/texlive/
  包含 LaTeX 核心工具和常用宏包，适合所有系统。

- **在线工具（无需安装）**
  [Overleaf](https://www.overleaf.com/)：在线 LaTeX 编辑器，支持实时协作和模板。

------

###  **安装编辑器（编写代码的工具）**

- **VS Code + LaTeX Workshop 插件**（功能强大，适合开发者）

- **Overleaf**（在线工具）

------

## 二、编写第一个 LaTeX 文档

---

###  **基本结构**

创建一个 `.tex` 文件（如 `demo.tex`），输入以下代码：

```latex
\documentclass{article}  % 文档类（article/report/book等）
\begin{document}
Hello, LaTeX!            % 正文内容
\end{document}
```

------

### **核心语法与排版元素**

1. **文档结构**

   - 标题、作者、日期：

     ```latex
     LATEX\title{论文标题}
     \author{你的名字}
     \date{\today}
     \maketitle  % 生成标题
     ```

   - 章节与段落：`\section{...}`, `\subsection{...}`, 段落通过空行分隔。

2. **列表与表格**

   - 无序列表：

     ```latex
     LATEX\begin{itemize}
       \item 第一项
       \item 第二项
     \end{itemize}
     ```

   - 表格示例（使用`tabular`环境）：

     ```latex
     LATEX\begin{tabular}{|c|c|}
       \hline
       姓名 & 分数 \\
       \hline
       张三 & 90 \\
       \hline
     \end{tabular}
     ```

3. **插入图片**

   - 使用`graphicx`包：

     ```latex
     LATEX\usepackage{graphicx}
     \includegraphics[width=0.5\textwidth]{figure.png}  % 图片路径
     ```

---

###  **数学公式与算法**

1. **数学模式**

   - 行内公式：`$e^{i\pi} + 1 = 0$` → $e^{i\pi} + 1 = 0$

   - 独立公式：
   $$
       \sum_{i=1}^n i = \frac{n(n+1)}{2}
   $$

     ```latex
     LATEX\[
       \sum_{i=1}^n i = \frac{n(n+1)}{2}
     \]
     ```

   - 多行公式（`align`环境）：

     ```latex
     LATEX\begin{align}
       f(x) &= x^2 + 2x + 1 \\
            &= (x+1)^2
     \end{align}
     ```

2. **算法排版**

   - 使用`algorithm2e`包：

     ```latex
     LATEX\begin{algorithm}[H]
       \KwIn{输入数据}
       \KwOut{输出结果}
       初始化变量\;
       \While{条件}{
         执行操作\;
       }
       \caption{算法示例}
     \end{algorithm}
     ```

---

### 参考文献与引用

1. **引用文献**

   - 创建`.bib`文件，添加文献条目：

     ```latex
     BIBTEX@article{key,
       author = "作者",
       title  = "标题",
       year   = "2023"
     }
     ```

   - 在文档中引用：

     ```latex
     LATEX\cite{key}  % 引用文献
     \bibliography{refs}  % 导入.bib文件
     ```

2. **交叉引用**

   - 标签与引用：

     ```latex
     LATEX\section{引言}\label{sec:intro}
     如章节~\ref{sec:intro} 所述...
     ```

---

### **幻灯片制作（Beamer）**

1. **Beamer基础**

   ```latex
   LATEX\documentclass{beamer}
   \usetheme{Madrid}  % 主题
   \title{你的标题}
   \begin{document}
   \begin{frame}
     \frametitle{第一页}
     内容...
   \end{frame}
   \end{document}
   ```

2. **分步动画**

   - 使用`\pause`或`\onslide`：

     ```latex
     LATEX\begin{itemize}
       \item 第一点 \pause
       \item 第二点
     \end{itemize}
     ```

------

## 三、编译文档生成 PDF

- 现代 TEX 引擎均可直接生成 PDF
  • 命令行
  • pdflatex /xelatex /lualatex + <文件名>[. tex ]
-  多次编译：读取并排版中间文件
  • 推荐 latexmk ：latexmk [<选项>] [<文件名>]
- 编辑器
  • 按钮的背后仍然是命令
  • PATH 环境变量：确定可执行文件的位置
  • VS Code ：配置 tools 和 recipes

------

## 四、调试与优化

### 1. **常见错误处理**

- **编译报错**：仔细阅读错误信息，定位代码行号，检查拼写或缺失的大括号 `{}`。
- **中文乱码**：使用 `ctex` 宏包，并选择 `XeLaTeX` 编译。
- **图片不显示**：检查文件路径和格式（支持 `.png`、`.pdf`、`.jpg`）。

### 2. **进阶技巧**

- **分文件编写**：将长文档拆分为多个 `.tex` 文件，用 `\input{file.tex}` 合并。

- **自定义命令**：在导言区定义快捷命令，例如：

  ```latex
  \newcommand{\R}{\mathbb{R}}  % 输入 \R 代表实数集符号
  ```

------

## 五、学习资源推荐

1. **Overleaf 官方教程**：[Learn LaTeX in 30 Minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes)
2. **社区**：[TeX Stack Exchange](https://tex.stackexchange.com/)（提问与解答）
