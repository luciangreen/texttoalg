# texttoalg
Text to Algorithm

Text to Algorithm is a SWI-Prolog algorithm that prepares to breason out file.txt with an algorithm for each word, producing a pastable Shell script file1a.txt, mainly used for postgraduate Pedagogy musings.  Breasoning is thinking of the x, y and z dimensions of objects, necessary for meeting grades.

# Getting Started

Please read the following instructions on how to install the project on your computer for breasoning out algorithms.

# Prerequisites

* Use a search engine to find the Homebrew (or other) Terminal install command for your platform and install it, and search for the Terminal command to install swipl using Homebrew and install it or download and install SWI-Prolog for your machine at <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a>.

# Mac, Linux and Windows (with Linux commands installed): Prepare to run swipl

* In Terminal settings (Mac), make Bash the default shell:

```
/bin/bash
```

* In Terminal, edit the text file `~/.bashrc` using the text editor Nano:

```
nano ~/.bashrc
```

* Add the following to the file `~/.bashrc`:

```
export PATH="$PATH:/opt/homebrew/bin/"
```

* Link to swipl in Terminal:

```
sudo ln -s /opt/homebrew/bin/swipl /usr/local/bin/swipl
```

# 1. Install manually

Download <a href="http://github.com/luciangreen/texttoalg/">this repository</a>, the <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter Repository</a> and the <a href="https://github.com/luciangreen/Text-to-Breasonings">Text to Breasonings Repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
mkdir GitHub
cd GitHub/
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","texttoalg").
../
halt.
```

# Running

* In Shell:
`cd texttoalg`
`swipl`
`['../Text-to-Breasonings/text_to_breasonings.pl'].`    
`['texttoalg'].`    

* Enter the following to breason out Breasonings,Breathsonings,Room,PartOfRoom,Direction,ObjectToPrepare and ObjectToFinish. (Note: takes quite a while.)
`texttoalg(u,u,u,u,true,true,true,true,true,true).`    

* Enter the following to breason out the Breasonings and Breathsonings:
`texttoalg(u,u,u,u,true,false,false,false,false,false).`    

* Before running texttobr, think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.

* Follow instructions in https://github.com/luciangreen/Text-to-Breasonings/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttoalg, texttobr, or texttobr2 to avoid medical problems.

* Before breasoning, breason out algdict1.txt and algdict2.txt to allow breasoning multiple instances by dragging them from Finder (Mac) to empty BBEdit window for file.txt, then enter:
`['../Text-to-Breasonings/text_to_breasonings.pl'].`
`texttobr2(u,u,u,u,true,false,false,false,false,false),texttobr(u,u,u,u).`

* Not recommended (due to idiosyncrasies of Shell, so breasoning out the dictionaries in the previous step may have to suffice): Copy and paste contents of file1a.txt into Terminal window (Mac) (one to a few lines at a time) to breason out algorithms for all instances of words.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
