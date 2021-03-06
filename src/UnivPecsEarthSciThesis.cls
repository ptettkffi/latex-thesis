% UnivPecsEarthSciThesis.cls
% 2019-04-02 Gábor Farkas gfarkas (at) gamma.ttk.pte.hu
% Identification
\ProvidesClass{UnivPecsEarthSciThesis}[2019/04/02 version 1.00 University of Pecs Doctoral School of Earth Sciences thesis]
\NeedsTeXFormat{LaTeX2e}

% Options
% Extends the report class
% No custom options for this class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions \relax
\LoadClass{report}

% Required packages
\RequirePackage{multirow}
\RequirePackage{listings}
\RequirePackage{lmodern}
\RequirePackage{etoolbox}
\RequirePackage[explicit]{titlesec}
\RequirePackage{siunitx}
\RequirePackage{textcomp}
\RequirePackage{amsmath}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{apacite}
\RequirePackage{natbib}
\RequirePackage{graphicx}
\RequirePackage{url}
\RequirePackage{float}
\RequirePackage{subfig}
% Specifies where to look for included images
\graphicspath{{images/}{./}{Images/}{figures/}{Figures/}}
% Define caption style
\RequirePackage[font={footnotesize}]{caption}
% Captions should be left-aligned when they fit in a single line.
\captionsetup{justification=justified,singlelinecheck=false}
\captionsetup[subfloat]{justification=centering}
% Do not include chapter into figure and table numbering
\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{equation}{chapter}
\AtBeginDocument{\counterwithout{lstlisting}{chapter}}

% Configure internal links
\hypersetup{
    linktoc=all
}

% Customize listings for algorithms
\newfloat{program}{htbp}{lop}
\floatname{program}{Program}
\def\lstfloatautorefname{Program}

% JavaScript language definition
\lstdefinelanguage{JavaScript}{
  keywords={break, case, catch, continue, debugger, default, delete, do, else, false, finally, for, function, if, in, instanceof, new, null, return, switch, this, throw, true, try, typeof, var, void, while, with},
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
  ndkeywords={class, export, boolean, throw, implements, import, this},
  keywordstyle=\color{blue}\bfseries,
  ndkeywordstyle=\color{darkgray}\bfseries,
  identifierstyle=\color{black},
  commentstyle=\color{purple}\ttfamily,
  stringstyle=\color{red}\ttfamily,
  sensitive=true
}

% Pseudocode language definition
\lstdefinelanguage{pseudo}{
  keywords={Require, require, If, if, Then, then, Else, else, End, end, While, while, Do, do, Case, case, Of, of, In, in, Until, until, For, for, Next, next, Set, set, Read, read, Get, get, Print, print, Display, display, Increment, increment, Decrement, decrement, Push, push, Pop, pop, Determine, determine, Compute, compute, Return, return, Call, call, Raise, raise, Throw, throw, Exception, exception, Procedure, procedure},
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
  keywordstyle=\color{blue}\bfseries,
  identifierstyle=\color{black},
  commentstyle=\color{purple}\ttfamily,
  stringstyle=\color{red}\ttfamily,
  sensitive=true
}

\lstset{aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  basicstyle={\small\ttfamily},
  numbers=none,
  captionpos=b,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=false,
  tabsize=4,
  literate={/}{{/\allowbreak}}{1},
  floatplacement=tbp,
  belowcaptionskip=0pt,
  belowskip=0pt,
  mathescape
}

% Geometry settings
\RequirePackage[a4paper,width=149mm,top=32mm,bottom=40mm,bindingoffset=-9mm]{geometry}

% New commands
\NewDocumentCommand{\advisor}{m}{\newcommand{\advisorname}{#1}}
\NewDocumentCommand{\coadvisor}{m}{\def\coadvisorname{#1}}
\NewDocumentCommand{\location}{m}{\newcommand{\locationname}{#1}}
\NewDocumentCommand{\univlogo}{m}{\newcommand{\univlogopath}{#1}}
\NewDocumentCommand\acknowledgements{}{%
	\chapter*{Acknowledgements}
	\addcontentsline{toc}{chapter}{Acknowledgements}
}
% A new bibliography command for creating APA references with a TOC entry
\NewDocumentCommand{\upbibliography}{om}{%
	\bibliographystyle{apacite}
	\IfValueT{#1}{%
		\cleardoublepage
		\phantomsection
		\addcontentsline{toc}{chapter}{#1}
	}
	\bibliography{#2}
}
% A new appendix command with correct numbering
\NewDocumentCommand{\upappendix}{m}{%
	\appendix
	\setcounter{figure}{0}
	\setcounter{table}{0}
	\setcounter{program}{0}
	\makeatletter
	\let\c@table\c@figure
	\let\ftype@table\ftype@figure
	\let\c@program\c@figure
	\let\ftype@program\ftype@figure
	\makeatother
	\captionsetup[table]{name=#1}
	\captionsetup[figure]{name=#1}
	\captionsetup[program]{name=#1}
}

% Default values
\coadvisor{}

% Wrap titles and subtitles into centered boxes
\def\tpe#1{%
  \hbox to \hsize{%
    \vbox{\centering #1}}}%

% Custom title page
\RenewDocumentCommand{\maketitle}{}{%
  \thispagestyle{empty}\vbox to \vsize{%
  	\tpe{%
  	\Large \textsc{University of P\'ecs}
  	}
  	\vspace{2mm}
  	\tpe{Faculty of Sciences}
  	\vspace{2mm}
  	\tpe{Doctoral School of Earth Sciences}
    \vfill
    \vfill
    \tpe{\LARGE \@title}
    \vfill
    \noindent
    Author: \hfill \ifdefempty{\coadvisorname}{Advisor:}{Advisors:} \\
    \@author \hfill \advisorname \\
    \ifdefempty{\coadvisorname}{\null}{\null\hfill \coadvisorname \\}
    \vfill
    \vfill
    \tpe{\includegraphics[width=2cm]{\univlogopath}}
    \vspace{5mm}
    \tpe{\small \locationname, \@date}{}
    }%
  \cleardoublepage
  \tableofcontents
}

% Define header styles
\titleformat{\chapter}{\Large}{}{0mm}{\noindent\thechapter.\quad\textsc{#1}}
\titleformat{name=\chapter,numberless}{\Large}{}{0mm}{\noindent\textsc{#1}}
\titleformat{\section}{\large}{}{0mm}{\noindent\thesection.\quad#1}
\titleformat{\subsection}{\large}{}{0mm}{\noindent\thesubsection.\quad#1}
\renewcommand{\contentsname}{Table of Contents}

% Since natbib is loaded, citep and citet should be used instead of cite
\AtBeginDocument{%
	\RenewDocumentCommand{\cite}{m}{%
		\PackageError{UnivPecsEarthSciThesis}{For inline citations, please use commands \citep and \citet.}{}
	}
}
