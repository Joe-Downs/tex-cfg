
% FILE: ulthesis.cls
% AUTHOR: John Kielkopf
%
% Contributors: Jeremy Huber, Elija Jensen, Biswas Diptaparna
%
% 
% Built on the memoir style with the additions derived from 
%   ukthesis.cls file written by Erik Stokes and dated 2015
% 
% USAGE: To meet the formatting requirements for the
%   University of Louisville School of Interdisciplinary and Graduate Studies
%
% VERSION: 6.2  (May 15, 2025)
%
% -----------------------------------------------------------------
%
% CHANGE LOG:
%   2018-01-06
%     Started with Jeremy Huber's version 5.0 from  a UK dissertation
%     Replaced instances of UK with UL
%     Moved frontmatter order to UL preferred order
%     Customized frontmatter
%     Cleaned code to remove unused components
%     Created new abstract environment 
%     Formatted chapter style
%     Added options in sample dissertation.tex to yield correct formatting
%
%   2018-06-26
%     Corrections to meet SIGS style review for Elijah Jensen
%
%   2018-09-19
%     Additional adjustments to meet final submission SIGS review
%     Used Elijah Jensen's dissertation as a template for examples 
%
%   2022-08-07
%     Changes needed by Biswas Diptaparna for SIGS approval
%
%   2023-05-26
%     Corrections to the main file and clarifying examples added.
%
%   2025-05-15
%     Added  \setsecnumdepth{subsubsection} to retain numbering
%     This is an option in the memoir class and can be commented out in the ulthesis.cls file






\def\fileversion{v6.0.0} 
\def\filedate{2018/09/19}

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{ulthesis}[\filedate\space\fileversion\space UL thesis class]

\newif\if@draft
\newif\if@pretty\@prettyfalse%use nice formatting instead of the grad schools
                %requirements 
\newif\if@sigs\@sigstrue%include names on the sig lines
%\newif\if@nofigures

\DeclareOption{nosignatures}{\@sigsfalse}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{memoir}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{memoir}}
\DeclareOption{draft}{\@drafttrue\PassOptionsToClass{draft}{memoir}}
\DeclareOption{pretty}{\@prettytrue}
\DeclareOption{final}{\@prettyfalse\@sigstrue\PassOptionsToClass{final,oneside,12pt}{memoir}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{memoir}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{memoir}}
\DeclareOption{a4paper}{\ClassWarning{ulthesis}{Option 'a4paper' is
    not available.  Defaulting to US letter paper}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ExecuteOptions{12pt}
\ProcessOptions\relax

%Use the memoir class as the foundation and modify as needed

\LoadClass{memoir}

% Optionally number the subsections
% Comment this out to leave them unnumbered, or drop the level to subsubsection

\setsecnumdepth{subsubsection}


\RequirePackage{calc}
%\RequirePackage{fullpage}
%% \RequirePackage{xspace}
%% \RequirePackage{enumerate}
%% \RequirePackage{fancyhdr}


% A command for optional typesetting
\newcommand{\pretty}[1]{}
\if@pretty\renewcommand{\pretty}[1]{#1}\fi

% Set the margins

%\RequirePackage[left=1.5in,right=1.0625in,top=1in,bottom=1in,footskip=0.5in]{geometry} 
%\settrimmedsize{\stockheight}{\stockwidth}{*}
\settrims{0in}{0in}
\setstocksize{11in}{8.5in}
\setlrmarginsandblock{1.5in}{1in}{*}
\setulmarginsandblock{1in}{1in}{*}

%\setlength{\evensidemargin}{\oddsidemargin}
\setheaderspaces{*}{\baselineskip}{*}
\newlength{\@extrafootskip}
\settoheight{\@extrafootskip}{1}
\setheadfoot{.5in}{.5in}%-\@extrafootskip}
\setmarginnotes{10pt}{1in}{1ex}
\checkandfixthelayout

% These lengths control the positioning of title page elements relative
%   to the margins.  Change these if the spec changes.

% Approval page
\newlength{\@aptitleskip}\setlength{\@aptitleskip}{3in}%skip this far
                                %before the title 
\newlength{\@aptitleheight}\setlength{\@aptitleheight}{1in}%you have
                                %this much space for the title 
\newlength{\@apbottomskip}\setlength{\@apbottomskip}{4in} %skip after
                                %the signature line 
% Title page
\newlength{\@titletopskip}\setlength{\@titletopskip}{2.in}
\newlength{\@titlebottomskip}\setlength{\@titlebottomskip}{2.in}
\newlength{\@titlelineskip}\setlength{\@titlelineskip}{2.5in}
\newlength{\@titlelinewidth}\setlength{\@titlelinewidth}{.8\linewidth}
\newlength{\@titletitleheight}\setlength{\@titletitleheight}{\@titlelineskip}

% Modify the above lengths to account for the margins
\newlength{\@topmatter}%\setlength{\@topmatter}{0in}
\newlength{\@bottommatter}\setlength{\@bottommatter}{0in}
\setlength{\@topmatter}{\uppermargin}
%\addtolength{\@topmatter}{\topmargin}
%\addtolength{\@topmatter}{\topsep}
%\addtolength{\@topmatter}{\headheight}
\addtolength{\@topmatter}{\headsep}
%\addtolength{\@topmatter}{1in}%the origin is 1in down
\addtolength{\@bottommatter}{\lowermargin}
%\addtolength{\@bottommatter}{\footskip}

% Set the lengths correctly for the approval page
\addtolength{\@aptitleskip}{-\@topmatter}
\addtolength{\@apbottomskip}{-\@bottommatter}

% Set lengths for the title page
\addtolength{\@titletitleheight}{-\@titletopskip}%gives 1.5in for title
\addtolength{\@titletopskip}{-\@topmatter}
\addtolength{\@titlebottomskip}{-\@bottommatter}
\addtolength{\@titlebottomskip}{-.75\baselineskip}

% Set dedication lengths
\newlength{\@dedicationskip}\setlength{\@dedicationskip}{4in}
\addtolength{\@dedicationskip}{-\@topmatter}

% Renew \maketitle and related commands
\newcommand{\@theyear}{\number\the\year}%the current year
\if@pretty\relax\else
\newcommand{\@theauthor}{}
\newcommand{\@thetitle}{}

\renewcommand{\author}[1]{
  \renewcommand{\@theauthor}{#1}
}

\renewcommand{\title}[1]{
  \renewcommand{\@thetitle}{\uppercase{#1}}
}
\fi

\newcommand{\@thekeywords}{}
\newcommand{\@theadvisor}{}
\newcommand{\@thefirstmember}{}
\newcommand{\@thesecondmember}{}
\newcommand{\@thethirdmember}{}
\newcommand{\@thefourthmember}{}

\newcommand{\@theauthordegree}{}
\newcommand{\@thedissertationdegree}{}
\newcommand{\@thedissertationdiscipline}{}
\newcommand{\@thedissertationdate}{}
\newcommand{\@theapprovaldate}{}
\newcommand{\@theschool}{}
\newcommand{\@thedepartment}{}


\newcommand{\keywords}[1]{
  \renewcommand{\@thekeywords}{#1}
}

\newcommand{\authordegree}[1]{
  \renewcommand{\@theauthordegree}{#1}
}

\newcommand{\dissertationdegree}[1]{
  \renewcommand{\@thedissertationdegree}{#1}
}

\newcommand{\dissertationdiscipline}[1]{
  \renewcommand{\@thedissertationdiscipline}{#1}
}

\newcommand{\dissertationdate}[1]{
  \renewcommand{\@thedissertationdate}{#1}
}

\newcommand{\approvaldate}[1]{
  \renewcommand{\@theapprovaldate}{#1}
}

\newcommand{\school}[1]{
  \renewcommand{\@theschool}{#1}
}

\newcommand{\department}[1]{
  \renewcommand{\@thedepartment}{#1}
}

\newcommand{\advisor}[1]{
  \renewcommand{\@theadvisor}{#1}
}

\newcommand{\firstmember}[1]{
  \renewcommand{\@thefirstmember}{#1}
}
\newcommand{\secondmember}[1]{
  \renewcommand{\@thesecondmember}{#1}
}
\newcommand{\thirdmember}[1]{
  \renewcommand{\@thethirdmember}{#1}
}
\newcommand{\fourthmember}[1]{
  \renewcommand{\@thefourthmember}{#1}
}


\newcommand{\makeapprovalpage}{
  \thispagestyle{plain}
  \setcounter{page}{2}
  \pdfbookmark[0]{Approval Page}{approvalpage}
    \begin{center}
      \rule{0in}{\@titletopskip+.75\baselineskip}
       %\vspace{-2\parskip}
      \par\noindent
       \parbox[c][\@titletitleheight][t]{\linewidth}{
           \begin{center}
             \vspace{-.75\baselineskip}
             \@thetitle
           \end{center}
       }
      \par\noindent

      \vspace{\parskip}
 
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
            \vspace{8ex}
            By \\ 
            \vspace{4ex}
            \@theauthor \\
            \@theauthordegree
          \end{center}
        }

      \vspace{\parskip}
     
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
            Dissertation approved on
          \end{center}
        }

      \vspace{\parskip}


      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}              
            \@theapprovaldate
          \end{center}
        }


      \vspace{\parskip}

      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
            by the following dissertation Committee:
          \end{center}
        }

      
      \vspace{\parskip}
        
      \parbox[c][][t]{\@titlelinewidth}{
        \begin{center}
          \vspace{4ex}
          \rule{20em}{0.25ex} \\
        %   Dissertation Director \\
          \@theadvisor \\
           \vspace{4ex}
           \rule{20em}{0.25ex} \\
           \@thefirstmember \\
           \vspace{4ex}
           \rule{20em}{0.25ex} \\
           \@thesecondmember \\
           \vspace{4ex}
           \rule{20em}{0.25ex} \\
           \@thethirdmember          
         \end{center}
       } 
        
      \vspace{\@titlebottomskip}

    \end{center}
    \newpage

}


\newcommand{\maketitlepage}{
  \thispagestyle{empty}
  \pdfbookmark[0]{Title Page}{titlepage}
    \begin{center}
      \rule{0in}{\@titletopskip+.75\baselineskip}
       %\vspace{-2\parskip}
      \par\noindent
       \parbox[c][\@titletitleheight][t]{\linewidth}{
           \begin{center}
             \vspace{-.75\baselineskip}
             \@thetitle
           \end{center}
       }
      \par\noindent

      \vspace{\parskip}
 
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
           \hspace{1em}\\
           \hspace{1em}\\
            By \\ 
            \@theauthor \\
            \@theauthordegree
          \end{center}
        }

      \vspace{\parskip}
     
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
            A Dissertation \\ 
            Submitted to the Faculty of the \\
            \@theschool  of the University of Louisville \\
            in Partial Fulfillment of the Requirements \\
            for the Degree of 
          \end{center}
        }

      \vspace{\parskip}
 
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
             \@thedissertationdegree \\
             in \@thedissertationdiscipline
          \end{center}
        }      

      \vspace{\parskip}
      
      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}
             \@thedepartment \\
             University of Louisville \\
             Louisville, Kentucky
          \end{center}
        }

      \vspace{\parskip}

      \parbox[c][][t]{\@titlelinewidth}{
          \begin{center}              
            \@thedissertationdate
          \end{center}
        }
        
      \vspace{\@titlebottomskip}

    \end{center}
    \newpage
}

\newcommand{\makecopyrightpage}{
  \thispagestyle{empty}
    \rule{0in}{\@titletopskip}
    \begin{center}
      Copyright \@theyear \/ by \@theauthor
    \end{center}
    
    \vspace{\parskip}
     \begin{center}
      All rights reserved
    \end{center}
   
    
    \newpage
    % add a blank page that is not in the ToC
    \thispagestyle{empty}
    \rule{0in}{\@titletopskip}
    \begin{center}
      ~  %This page intentionally left blank.
    \end{center}
    
    \newpage

}


\newenvironment{epigraph_page}{
  \clearpage
  \chapterstyle{nonumbers}
  \chapter[epigraph]{\textnormal{\normalsize{}}}
  %\thispagestyle{plain}
  \begin{center}{\textnormal{\normalsize{}}}\end{center} 
}{
  %\clearpage
  \clearpage
}



\newenvironment{dedication}{
  \clearpage
  %\topmargin = 1in
  \chapterstyle{nonumbers}
  \chapter*[Dedication]{\textnormal{\normalsize{DEDICATION}}} %do not display in TOC so use *
  %\thispagestyle{plain}
  %\begin{center}{\textnormal{\normalsize{DEDICATION}}}\end{center}
  \begin{DoubleSpace}
}{
  %\clearpage
  \end{DoubleSpace}
  \clearpage
}

\newenvironment{acknowledgments}{
  \clearpage
  %\topmargin = 1in
  \chapterstyle{nonumbers}
  \chapter[Acknowledgments]{\textnormal{\normalsize{ACKNOWLEDGMENTS}}}
  %\thispagestyle{plain}
  %\begin{center}{\textnormal{\normalsize{ACKNOWLEDGMENTS}}}\end{center}
  \begin{DoubleSpace}
}{
  %\clearpage
  \end{DoubleSpace}
  \clearpage
}

\newenvironment{dissertationabstract}{
  \clearpage
  %\topmargin = 1in
  \chapterstyle{nonumbers}
  \chapter[Abstract]{\textnormal{\normalsize{ABSTRACT}}}
  \begin{center}
  \@thetitle \\
  \@theauthor \\
  \@theapprovaldate
  \end{center}
  %\thispagestyle{plain}
  \begin{DoubleSpace}
}{
  %\clearpage
  \end{DoubleSpace}
  \clearpage
}

% Required front matter included here will not have page numbers

\if@pretty\relax\else
\renewcommand{\maketitle}{
  \begin{titlingpage}
    \maketitlepage
    \makecopyrightpage
    \makeapprovalpage  
  \end{titlingpage}
  \setcounter{page}{3}
  %\pagestyle{plain}
}
\fi


% Customize list of tables
\renewcommand{\listtablename}{List of Tables}
%\renewcommand{\lotheadstart}{}
% Add space above lot title
\renewcommand{\lotheadstart}{\vspace*{1in}}
\renewcommand{\printlottitle}[1]{\hfill\normalsize\MakeUppercase{{\normalfont{#1}}}\hfill}

% Customize list of figures
\if@pretty\relax\else
\renewcommand{\listfigurename}{List of Figures}
%\renewcommand{\lofheadstart}{}
% Add space above the lof title
\renewcommand{\lofheadstart}{\vspace*{1in}}
\renewcommand{\printloftitle}[1]{\hfill\normalsize{\MakeUppercase{\normalfont{#1}}}\hfill}

% Customize table of contents
\renewcommand{\contentsname}{TABLE OF CONTENTS}
% \renewcommand{\tocheadstart}{}
% Add space above toc title
\renewcommand{\tocheadstart}{\vspace*{1in}}
% This line controls what is printed at the top of the toc
\renewcommand{\printtoctitle}[1]{\hfill\normalsize\MakeUppercase{{\normalfont{#1}}}\hfill}
% Set to have no title at the top of the toc by inserting blank space
% \renewcommand{\printtoctitle}[1]{\hfill\normalsize\MakeUppercase{{\normalfont{\hspace{1em}}}}\hfill}
\renewcommand{\cftchapterpagefont}{\normalfont}
\renewcommand{\cftchapterfont}{\normalfont}
\renewcommand{\cftpartfont}{\normalfont}
\renewcommand{\cftpartpagefont}{\normalfont}
%\renewcommand{\changetocdepth}[1]{}
% Add the word chapter to the toc
%\renewcommand{\cftchapterpresnum}{Chapter\ }
% Gobble chapter number in ToC
\renewcommand{\chapternumberline}[1]{}

\newlength{\toctemp}
\settowidth{\toctemp}{\cftchapterpresnum}
\addtolength{\cftchapternumwidth}{\toctemp} 
% Add dots to the chapter lines
\renewcommand{\cftdot}{.}
\renewcommand{\cftchapterleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
\fi

% Customize the header and footer styles
\if@pretty\relax\else\pagestyle{plain}\fi

% Customize the chapter styles
\makechapterstyle{small}{%
  \renewcommand{\printchaptername}{\normalfont\bfseries Chapter}
  \renewcommand{\chapnumfont}{\normalfont}
  \renewcommand{\chapnamefont}{\normalfont}
  \renewcommand{\printchapternum}{\normalfont \thechapter\space} %removed \bfseries
  \renewcommand{\afterchapternum}{\normalfont}
  \renewcommand{\printchaptertitle}[1]{\normalfont ##1} %removed \bfseries
  \setlength{\beforechapskip}{0.75in}
}
\makechapterstyle{nonumbers}{
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapnumfont}{\normalfont}
  \renewcommand{\chapnamefont}{\normalfont}
  \renewcommand{\printchapternum}{}
  \renewcommand{\afterchapternum}{\normalfont}
  \renewcommand{\printchaptertitle}[1]{\begin{center}##1\end{center}}
  \setlength{\beforechapskip}{0.75in}
}
\makechapterstyle{ult}{%
  \renewcommand{\thechapter}{\Roman{chapter}}
  \renewcommand{\chapnumfont}{\normalfont} %removed bfseries
  \renewcommand{\chapnamefont}{\normalfont} %removed bfseries
  \renewcommand{\printchaptername}{\begin{center}\chapnamefont CHAPTER}
  \renewcommand{\printchapternum}{\chapnumfont\thechapter\space}
  \renewcommand{\afterchapternum}{\normalfont\end{center}}
  \renewcommand{\printchaptertitle}[1]{\normalfont\begin{center}\uppercase{##1}\end{center}} %removed \bfseries 
  \setlength{\beforechapskip}{0.75in}
}
% Select the default styles
\if@pretty\relax\else
\chapterstyle{ult}
\setsecheadstyle{\bfseries} 
\setsubsecheadstyle{\bfseries}
\setsubsubsecheadstyle{\bfseries}
\linespread{1.6} %select double spaced text per UofL SIGS 
\fi

% Change default bibliography name to references in toc and as title on first page
\renewcommand{\bibname}{REFERENCES}
