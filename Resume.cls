%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Small, Medium, Large Length Professional CV - RESUME CLASS FILE
%
% This class file defines the structure and design of the template.
%
% PROPRIETARY SOFTWARE LICENSE
% Copyright (C) 2025 by Omar Shawky
% All rights reserved.
%
% This work is protected by copyright and is proprietary software.
% 
% RESTRICTIONS:
% - No part of this publication may be reproduced, distributed, or transmitted
%   in any form or by any means, including photocopying, recording, or other
%   electronic or mechanical methods, without the prior written permission
%   of the copyright holder.
% - Reverse engineering, decompilation, or disassembly is strictly prohibited.
% - Commercial use, modification, or derivative works are not permitted.
% - This software is licensed for personal viewing and evaluation only.
%
% VIOLATION NOTICE:
% Unauthorized copying, distribution, modification, or use of this software
% constitutes copyright infringement and may result in legal action.
%
% For licensing inquiries and permission requests:
% Contact: https://linkedin.com/in/omarshawky1/
%
% Created by Omar Shawky
%
% Custom Style Version: V5.6.2-Deprecate-old-tables
% Author: Omar Shawky
% LinkedIn: https://linkedin.com/in/omarshawky1/
% Date: 2025-07-01
%
% Author Omar's Notes:
% Code is intended to run on compiler "pdflatex" version: 2020(legacy) on overleaf. For 2023+, use "Table2" Style.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/07/01 V5.6.2-Deprecate-old-tables Resume & CV class]

% Class options handling
\DeclareOption{cv}{\def\@documenttype{cv}}
\DeclareOption{resume}{\def\@documenttype{resume}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
% To use CV style, write the following as your class document: \documentclass[cv]{resume}
%\documentclass[cv]{resume} % Use the custom resume.cls style


% Set default document type if not specified
\@ifundefined{@documenttype}{\def\@documenttype{resume}}{}

%----------------------------------------------------------------------------------------
% Base Class and Core Packages
%----------------------------------------------------------------------------------------

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

% Core packages with proper dependency order
% \RequirePackage{etoolbox}    % Implicitly imported. Provides robust programming tools. Used for throwing errors such as "\ClassError{resume}{Invalid job counter state}{}".
\RequirePackage{xparse}      % used for any mmooo...
\RequirePackage{ifthen}      % Required for ifthenelse statements
\RequirePackage[parfill]{parskip} % Remove paragraph indentation

% Math and calculation packages
\RequirePackage{fp}          % For floating point calculations

% Layout and formatting packages (For page layout)
\RequirePackage{geometry}    % Page layout

% Used in Profile Picture
\RequirePackage{graphicx}
\RequirePackage[absolute,overlay]{textpos}
% How to use: (you can tinker with values because each image is different)
% \begin{textblock*}{\paperwidth}(\dimexpr7in+0.13in,0.3in)\noindent\includegraphics[scale=0.35]{omar-shawky.png}\end{textblock*}

% Link and reference packages
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  filecolor=magenta,
  urlcolor=blue,
  pdfborder={0 0 0}
}

%----------------------------------------------------------------------------------------
% Page Layout Configuration
%----------------------------------------------------------------------------------------

% Dynamic margins based on document type
\ifthenelse{\equal{\@documenttype}{cv}}{
  \geometry{left=0.4in,top=0.4in,right=0.4in,bottom=0.8in}
  \RequirePackage{fancyhdr}
  \RequirePackage{lastpage}
  \pagestyle{fancy}
  \fancyhf{}
  \fancyfoot[C]{\thepage/\pageref{LastPage}}
  \renewcommand{\headrulewidth}{0pt}
}{
  \geometry{left=0.4in,top=0.4in,right=0.4in,bottom=0.4in}
  \pagestyle{empty} % Suppress page numbers for resume
}

%----------------------------------------------------------------------------------------
% Advanced Features Packages
%----------------------------------------------------------------------------------------
% Table packages
%  For rTable1
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}
% For rTable2 & rTable3
% \RequirePackage{longtable}
% \RequirePackage{tabu}

% Bibliography and citation packages
\RequirePackage[numbers]{natbib}

% Additional formatting packages
\RequirePackage{amsmath}
\RequirePackage{mdframed}
\RequirePackage{tokcycle}
\RequirePackage[inline]{enumitem}
\RequirePackage{multicol}
\RequirePackage{adjustbox}

%----------------------------------------------------------------------------------------
% Document Constants and Configuration
%----------------------------------------------------------------------------------------

% Typography settings
\newcommand*{\namesize}{\Huge}
\newcommand*{\jobsize}{\Large}
\newcommand*{\addressSep}{$\diamond$}

% Spacing settings
\newcommand*{\addressskip}{\smallskip}
\newcommand*{\sectionlineskip}{\medskip}
\newcommand*{\nameskip}{\medskip}
\newcommand*{\sectionskip}{\medskip}

% Compression system with validation
% \RequirePackage{fp} % For floating point calculations of decompress
\newcommand*{\compress}{0} % Value between 0 and 100
\@ifundefined{compress}{\newcommand*{\compress}{0}}{}

% Validate compression value
\ifnum\compress<0\relax
  \ClassWarning{resume}{Compression value \compress\space is negative, setting to 0}
  \renewcommand*{\compress}{0}
\fi
\ifnum\compress>100\relax
  \ClassWarning{resume}{Compression value \compress\space exceeds 100, setting to 100}
  \renewcommand*{\compress}{100}
\fi

% Calculate decompression factor
\FPeval{\decompress}{1 - (3*\compress)/1000}
\newcommand*{\decompressMinVal}{0.7}

% Apply compression to spacing
\parskip=\decompress\parskip
\newcommand*{\rItemizeSkip}{\vspace*{-0.5\baselineskip}}
\newcommand*{\rItemizeSkipN}{\vspace*{0.5\baselineskip}}

% Values that aren't useful yet
% For reference, check [overleafhttps](://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX) especially primitive commands section
% \parindent=0pt
% \baselineskip=\decompress\baselineskip
% \lineskiplimit=\decompress\lineskiplimit
% \lineskip=\decompress\lineskip
%\newcommand{\tab}[1]{\hspace{.2667\textwidth}\rlap{#1}}
%\newcommand{\itag}[1]{\hspace{0em}\rlap{#1}}
%----------------------------------------------------------------------------------------
% Command Definition Macros
%----------------------------------------------------------------------------------------
% Helper macro for conditional content
\newcommand*{\@IfValueThenElse}[3]{
  \ifstrempty{#1}{#3}{#2}
}

%----------------------------------------------------------------------------------------
% Name and Title Commands
%----------------------------------------------------------------------------------------

% Robust command definitions with error checking
 % Defines the \name command to set name
\NewDocumentCommand{\name}{m}{
  \ifstrempty{#1}{
    \ClassError{resume}{Name cannot be empty}{}
  }{
    \gdef\@name{#1}
  }
}
\newcommand*{\@name}{} % Sets \@name to empty by default

% Defines the \@role command to set role
\NewDocumentCommand{\role}{m}{
  \gdef\@role{#1}
}
\newcommand*{\@role}{} % Sets \@role to empty by default


% Print name with proper formatting as a page header
\newcommand*{\printname}{
  \begingroup
    \ifdefempty{\@role}{ % If role is not provided
      \centerline{\namesize{\textbf{\MakeUppercase{\@name}}}} % Print only the name
    }{
      \centerline{\namesize{\textbf{\MakeUppercase{\@name, \@role}}}} % Print name and role
    }
    \ifdefempty{\@JobTitle}{\nameskip}{\bigskip} % If job title is not provided, add a small skip
  \endgroup
}

% How to use:
% \name{Your Name}
% \role{Your Role} % Optional, you can comment it out
% \JobTitle{Software Engineer} % Bold Job Title, use this OR the \job command below

%----------------------------------------------------------------------------------------
% Job and Address Commands
%----------------------------------------------------------------------------------------

% Job handling with improved logic
% One, two or three job lines can be specified
\newcounter{jobcount}
\newcommand*{\@jobone}{}
\newcommand*{\@jobtwo}{}
\newcommand*{\@jobthree}{}

\NewDocumentCommand{\job}{m}{
  \stepcounter{jobcount}
  \ifcase\value{jobcount}
    % Case 0: should not happen
    \ClassError{resume}{Invalid job counter state}{}
  \or% Case 1
    \gdef\@jobone{#1}
  \or% Case 2  
    \gdef\@jobtwo{#1}
  \or% Case 3
    \gdef\@jobthree{#1}
  \else
    \ClassWarning{resume}{Maximum of 3 jobs supported, ignoring excess}%
  \fi
}

% Print job with proper formatting
\newcommand*{\printjob}[1]{
  \begingroup
    \def\\{\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% How to use: (Note: you can use \job command up to 3 times at most)
% \job{one \\ two \\ three} % put at least one job but can put as many jobs as you want
% \job{Software Engineer \\ Electrical \& Communications Engineer \\ Academic Writer} % put at least one job but can put as many jobs as you want

% Style 2
\NewDocumentCommand{\JobTitle}{m}{ % Defines the \JobTitle command to set job title
  \gdef\@JobTitle{#1}
}
\newcommand*{\@JobTitle}{} % Sets \@JobTitle to empty by default
% Old job title printing
\newcommand*{\printJobTitle}{
  \begingroup
    \centerline{\MakeUppercase{\jobsize\bfseries \@JobTitle}}
    \nameskip
  \endgroup
}

% How to use:
% \JobTitle{Software Engineer} % Job title
%----------------------------------------------------------------------------------------
% Address Section
% One, two or three address lines can be specified
\newcounter{addresscount}
\newcommand*{\@addressone}{}
\newcommand*{\@addresstwo}{}
\newcommand*{\@addressthree}{}

\NewDocumentCommand{\address}{m}{%
  \stepcounter{addresscount}%
  \ifcase\value{addresscount}%
    \ClassError{resume}{Invalid address counter state}{}%
  \or% Case 1
    \gdef\@addressone{#1}%
  \or% Case 2
    \gdef\@addresstwo{#1}%
  \or% Case 3
    \gdef\@addressthree{#1}%
  \else
    \ClassWarning{resume}{Maximum of 3 addresses supported, ignoring excess}%
  \fi
}

% Print address with proper formatting
\newcommand*{\printaddress}[1]{
  \begingroup
    \def\\{\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% How to use: (Note: you can use \address command up to 3 times at most)
% \address{one \\ two \\ three} % put at least one address but can put as many addresses as you want
% \address{+0(000) 000-00000 \\ \href{x@gmail.com}{x@gmail.com} \\ Palo Alto, California, US}
% \address{\href{https://linkedin.com/in/X}{linkedin.com/in/X} \\ \href{https://github.com/X}{github.com/X} \\ \href{https://github.com/X}{Website}}

%----------------------------------------------------------------------------------------
% Document Begin/End Hooks
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{%
  \ori@document
  \printname
  \ifdefempty{\@JobTitle}{}{\printJobTitle}
  \ifdefempty{\@jobone}{}{\printjob{\@jobone}}
  \ifdefempty{\@jobtwo}{}{\printjob{\@jobtwo}}
  \ifdefempty{\@jobthree}{}{\printjob{\@jobthree}}
  \ifdefempty{\@addressone}{}{\printaddress{\@addressone}}
  \ifdefempty{\@addresstwo}{}{\printaddress{\@addresstwo}}
  \ifdefempty{\@addressthree}{}{\printaddress{\@addressthree}}
}

%----------------------------------------------------------------------------------------
% Section Formatting
%----------------------------------------------------------------------------------------
% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
\begin{rSection1}{#1}
}{
\end{rSection1}
}

% How to Use:
\iffalse
  \begin{rSection}{Section Title}
    % Write here anything. From list to paragraphs. Refer to Template.tex for examples.
  \end{rSection}
\fi

%----------------------------------------------------------------------------------------
% Implementation
% Dev Notes: This is made to solve a problem with the \item command and kept for the future

% Implementation 1
\newenvironment{rSection1}[1]{ % 1 input argument - section name
  \sectionHeading{#1}
  \begin{list}{}{ % List for each individual item in the section
      \setlength{\leftmargin}{0em} % Margin within the section
    }
    \item
}{
  \end{list}
}
\newcommand*{\sectionHeading}[1]{
  \ifthenelse{\equal{\compress}{100}}{}{\sectionskip}
  \MakeUppercase{\textbf{#1}}
  \sectionlineskip
  \hrule
}

% How to Use:
\iffalse
  \sectionHeading{Title} % Section title
\fi

%----------------------------------------------------------------------------------------
% Section Formatting (Designed Mainly for Work Experience)
%----------------------------------------------------------------------------------------
% \RequirePackage{xparse} % used for any mmooo...
% \RequirePackage{tokcycle}
% Token cycle directive for hyperlink parsing
\Macrodirective{\addcytoks[1]{\string#1}} % needed for backslash

% 4 mandatory arguments and 3 optional arguments
% Role, Company Name, Date, Location: (Gov, Country) or (City, State), Company Description, Project Link, Project Name
% Date: Mon Year \\ Mon Year: Aug 2019 - Sep 2023
% (Gov, Country): Cairo, Egypt
% (City, State): (Palo Alto, CA), (LA, CA), (Upstate, NY), (San Francisco, CA), (Philadelphia, PA)
\NewDocumentEnvironment{rSubsection}{m m m o o o o}{
  % To change style, just replace rSubsection1 with the other style
  \begin{rSubsection1}{#1}{#2}{#3}[#4][#5][#6][#7]
  \end{rSubsection1}
}{}

% How to Use:
\iffalse
  % For Work Experience (Full time, Internship, Training), Extracurricular Experience, Leadership Experience
  \begin{rSubsection}
    {Role}
    {Company Name}
    {Start Date \\ End Date}
    [Location]
    [Company description] % Optional, erase if unneeded
    \begin{rItemize}
      \ritem Achieved X As Measured by Y Using Z.
      \begin{rItemize}
        \ritem Achieved X, by doing Z.
        \ritem Achieved X, as measured by Y, by doing Z.
        \ritem Achieved X\%, as measured by Y, by using technologies A, B and skills C, D.
        \ritem Achieved X\% growth for Y, by using technologies A, B and skills C, D.
        \ritem Led X, Y that led to Z\% of improvement in A, B, C.
      \end{rItemize}
      \ritem Designed, built, and developed X that did Y and Z, using A and B.
    \end{rItemize}
  \end{rSubsection}
\fi

% Note for the future: Date parsing is left for user, if this needs to change, check these working solution: https://tex.stackexchange.com/questions/693370/how-to-replace-single-hyphen-with-other-text-such-as-double-hyphen

% Old way
\iffalse
  \NewDocumentEnvironment{rSubsection}{mmmmo}{ % 4 mandatory arguments and 1 optional argument
  {\bf #1} \hfill {#2} % Bold company name and date on the right
  \\
  {#3} \hfill {\em #4} % Italic job title and location
  \IfValueT{#5}{ % If the fifth argument is specified, print the company description
    \\
    \small{#5}
  }
  \smallskip
  }{}

  % How to Use:
  \begin{rSubsection}{Role}{Aug 2019 - Sep 2023}{Company Name}{City, Country}
    \begin{rItemize}
      \item
    \end{rItemize}
  \end{rSubsection}

  \begin{rSubsection}{Role}{Aug 2019 - Sep 2023}{Company Name}{City, Country}[Company description]
    \begin{rItemize}
      \item
    \end{rItemize}
  \end{rSubsection}
\fi

%----------------------------------------------------------------------------------------
% Implementation
% Implementation 1: Standard layout
% Bold Role, Company Name, Emphasised Location and date on the right
\NewDocumentEnvironment{rSubsection1}{m m m o o o o}{
  \textbf{#1}, % Bold Role
  {#2}% Company Name
  \ifthenelse{\equal{#4}{}}{}{, \textit{#4}}. % Emphasised Location
  \hfill {\def \\ {--\ } #3} % Date on the right
  \\ % New line then - line is used to align portfolio link with date. It is correct in rSubsection2 & 3 because they create new line unlike inrSubsection1
  \vspace{-\baselineskip}
  \begin{rSubSectionCompanyDescription}[#5][#6][#7]
  \end{rSubSectionCompanyDescription}
}{}

% Implementation 2: Long company names
% Bold Role, date on the right
% Company Name, emphasised Location on the right
\NewDocumentEnvironment{rSubsection2}{m m m o o o o}{
  \textbf{#1}% Bold Role
  \hfill {\def \\ {--\ } #3}% Date
  \\
  {#2}% Company Name
  \hfill {\def \\ {--\ } \textit{#4}}% Emphasised Location on the right
  \begin{rSubSectionCompanyDescription}[#5][#6][#7]
  \end{rSubSectionCompanyDescription}
}{}

% Implementation 3: Company name first
% Bold Company Name, emphasised Location on the right
% Role, date on the right
\NewDocumentEnvironment{rSubsection3}{m m m o o o o}{
  \textbf{#2}% Bold Company Name
  \hfill {\def \\ {--\ } \textit{#4}}% Emphasised Location on the right
  \\
  {#1}%  Role
  \hfill {\def \\ {--\ } #3}% Date
  \begin{rSubSectionCompanyDescription}[#5][#6][#7]
  \end{rSubSectionCompanyDescription}
}{}

% Company description handler
% Signature: Company Description, Project link Name, Project Link
\NewDocumentEnvironment{rSubSectionCompanyDescription}{o o o}{
  \IfValueT{#1}{ % Company Description (If the fifth argument is specified)
    \\
    \IfValueF{#2}{ % Default Company Description (If Project link is not available)
      \begin{minipage}[t]{0.99\textwidth} % To prevent company description from overflowing page width
        \raggedright\small{#1}
      \end{minipage}
      \ifthenelse{\equal{\compress}{0}}
      {}
      {\rItemizeSkip}
    }
    \begin{rOpenSourceSubsectionProject}[#1][#2][#3]
    \end{rOpenSourceSubsectionProject}
  }\par
}{}

% Open source project handler
% Signature: Company Description, Project link Name, Project Link
\NewDocumentEnvironment{rOpenSourceSubsectionProject}{o o o}{
  \IfValueT{#2}{ % Open Source Project or Self Education (If specified, print it)
    \begin{minipage}[t]{0.819\textwidth} % Company Description (with 0.82 to make it not reach project name)
      \raggedright\small{#1}
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.183\textwidth}
      \tokcyclexpress{#2} % For parsing hyperlinks
      \raggedleft
      \IfValueT{#3}{ % Used to prevent needing to write empty []
        \ifthenelse{\equal{#3}{}}
        {\expandafter\href\expandafter{\the\cytoks}{GitHub Link}}
        {\expandafter\href\expandafter{\the\cytoks}{#3}}
      }
    \end{minipage}\par
  }
}{}

%----------------------------------------------------------------------------------------
% Education Environments
%----------------------------------------------------------------------------------------
% 3 mandatory arguments and 1 optional argument
% Degree and Field, Place, Date, Location,
% Degree and field: B.S. Computer Science.
% Date: Mon Year \\ Mon Year: Aug 2019 - Sep 2023
% Location: San Jose, CA (Check below for more options)
\NewDocumentEnvironment{rESubsection}{v m m o o}{
  \begin{rSubsection}{#1}{#2}{#3}[#4] % Bold Degree name, university name and date on the right.
  \end{rSubsection}
  \par
}{}

% How to use:
\iffalse
  \begin{rESubsection}
    {Degree and field}
    {University Name}
    {Start Date \\ End Date}
    [Location] % Optional
  \end{rESubsection}
\fi

% Not recommended to use this style directly. Instead, rely on choosing your rSubsection style and make it global
% left in case one wants to use it
\NewDocumentEnvironment{rESubsection2}{v m m o o}{
  \begin{rSubsection2}{#1}{#2}{#3}[#4] % Bold Degree name and date on the right. New Line university name and location on the right.
  \end{rSubsection2}
  \par
}{}

%----------------------------------------------------------------------------------------
% Open Experience Environments
%----------------------------------------------------------------------------------------
% For Open Source Projects, Self-Education, Freelance jobs, Career Breaks/Hiatus (E.g., Self learning, illness...)
% 3 mandatory arguments and 3 optional arguments
% Open Role, Open Explanation, Date, Open Description, Project Link, Project Name
% Date: Mon Year \\ Mon Year: Aug 2019 - Sep 2023
% Open Role: Self-Learning, Freelancing, Career Break.
% Open Explanation: (Educational: OSSU & MOOCs) (Freelance: Created X Project) (Career Break: Taking care of my newborn)
\NewDocumentEnvironment{rOSubsection}{m m m o o o}{
  \begin{rSubsection}{#1}{#2}{#3}[][#4][#5][#6]
  \end{rSubsection}
}{}

% How to Use:
\iffalse
  % For Open Source Projects
  \begin{rOSubsection}
    {Paid Contributor}
    {Chromium Web Browser}
    {Mar 2024 \\ Present}
    [Open source web browser which Chrome, Edge, and Brave are built on.]
    [https://github.com/OmarShawky1/CS-Roadmap#projects]
    [Pull Requests]
    \begin{rItemize}
      \ritem [Built X which did A, B, and C using D, E, and F.][https://github.com/][PR]
      \ritem [Developed Y which did A, B, and C using D, E, and F.][https://github.com/][PR]
      % Highly unrecommended unless necessary
      \begin{rItemize}
        \ritem Achieved X\% As Measured by Y by using/doing Z.
        \ritem Achieved X\% growth for XYZ using A, B, and C skills/technologies.
        \ritem Led XYZ which led to X\% of improvement in ABC.
        \ritem Leveraged knowledge X, Y, Z.
      \end{rItemize}
      % Most of the following points are rarely used for open source.
      \ritem Achieved X\% As Measured by Y by using/doing Z.
      \ritem Achieved X\% growth for XYZ using A, B, and C skills/technologies.
      \ritem Led XYZ which led to X\% of improvement in ABC.
      \ritem Leveraged knowledge X, Y, Z.
    \end{rItemize}
  \end{rOSubsection}

  % For Self-Education, Freelance Jobs
  \begin{rOSubsection}
    {Open Role}
    {Open Explanation with \href{https://github.com/OmarShawky1/CS-Roadmap\#projects}{Link}} % If it is education
    {Date \\ Date}
    \begin{rItemize}
      \ritem Achieved X\% As Measured by Y by using/doing Z.
      \ritem Achieved X\% growth for XYZ using A, B, and C skills/technologies.
      \ritem Led XYZ which led to X\% of improvement in ABC.
      \ritem Developed XYZ that did A, B, and C using X, Y, and Z.
    \end{rItemize}
  \end{rOSubsection}

  % For Self-Education, Freelance Jobs
  \begin{rOSubsection}
    {Open Role}
    {Open Explanation} % If it is education
    {Start Date \\ End Date}
    [Open Explanation] % Educational Sources Explanation, Freelance Project Explanation
    [https://github.com/OmarShawky1/CS-Roadmap#projects]  % Optional
    [Project Name] % Optional, replace "Project Name" or leave it empty for default naming. empty if Career Break
    \begin{rItemize}
      \ritem Achieved X\% As Measured by Y by using/doing Z.
      \ritem Achieved X\% growth for XYZ using A, B, and C skills/technologies.
      \ritem Led XYZ which led to X\% of improvement in ABC.
      \ritem Developed XYZ that did A, B, and C using X, Y, and Z.
    \end{rItemize}
  \end{rOSubsection}

  % For Certificates
  \begin{rOSubsection}
    {AZ-400} % Certificate Name
    {Designing \& Implementing Microsoft DevOps Solutions} % Explanation
    {Mar 2024} % Issued Date
  \end{rOSubsection}

  % For Career Breaks/Hiatus
  \begin{rOSubsection}
    {Taking care of elders} % Situation name
    {Taking care of parents due to emergency} % Explanation
    {Mar 2023 \\ Mar 2024} % Issued Date
  \end{rOSubsection}
\fi

%----------------------------------------------------------------------------------------
% Enhanced Item Commands
%----------------------------------------------------------------------------------------

% Item format
% Format specifically written for open source projects as to add PR at end of line.
% Does not affect any other piece of code if not used as expected
% Define \ritem with three optional arguments
\NewDocumentCommand{\ritem}{O{} O{} O{}}{
  \ifblank{#2}{% Check if the URL (second argument) is empty
    \item #1 % Only show the description if URL is not provided
  }{
    \item % Start the item
    \begin{minipage}[t]{0.85\textwidth}
      #1 % First optional argument (description)
    \end{minipage}
    % Numbers were arbitrarly calculated:
    % 1. to fit width without overflowing to the Project Link (in company description not the item which is we are currently editing)
    % 2. from using min and max decompression values (1 and 0.7 respectively) and min width values (0.1 (old number before this edit), 0.12 respectively). Use linear equation formula (y = mx + b) to calculate the equation below.
    % y2 = 0.12, y1 = 0.1
    % x2 = 0.7, x1 = 1
    % y = (-1/15)x + 1/6
    \FPeval{\rightMiniPageSize}{(0.97 / 6) - (\decompress/15)}
    \begin{minipage}[t]{\rightMiniPageSize\textwidth}
      \raggedleft
      \href{#2}{#3} % Second argument (URL), third argument (display text)
    \end{minipage}\par
  }
}
% How to Use:
\iffalse
  \ritem [Built X which did A, B, and C using D, E, and F.][https://github.com/][PR]
\fi


% Old Implementation. Replaced with above because of the newly added publications. Kept for reference.
\iffalse
\let\olditem\item
\RenewDocumentCommand{\item}{ooo}{
  \IfValueTF{#1}
  {
    \begin{minipage}[t]{0.85\textwidth}
      \olditem #1
    \end{minipage}
    % Numbers were arbitrarly calculated:
    % 1. to fit width without overflowing to the Project Link (in company description not the item which is we are currently editing)
    % 2. from using min and max decompression values (1 and 0.7 respectively) and min width values (0.1 (old number before this edit), 0.12 respectively). Use linear equation formula (y = mx + b) to calculate the equation below.
    % y2 = 0.12, y1 = 0.1
    % x2 = 0.7, x1 = 1
    % y = (-1/15)x + 1/6
    \FPeval{\rightMiniPageSize}{(1 / 6) - (\decompress/15)}
    \begin{minipage}[t]{\rightMiniPageSize\textwidth}
      \raggedleft
      \href{#2}{#3}
    \end{minipage}\par
  }
  {\olditem}
}
\fi

% How to Use:
\iffalse
  \item [Built X which did A, B, and C using D, E, and F.][https://github.com/][PR]
\fi

%----------------------------------------------------------------------------------------
% Project Environments
%----------------------------------------------------------------------------------------
% 2 mandatory arguments and 2 optional arguments
% Project Name, Project Description, Project Link, Link Name
\NewDocumentEnvironment{rProjects}{m m o o}{
  \textbf{#1}. {#2} % Bold Project Name then Description
  \IfValueT{#3}{
    \tokcyclexpress{#3} %For parsing hyperlinks
    \ifthenelse{\equal{#4}{}} % Project Link & Name
      {\hfill \expandafter\href\expandafter{\the\cytoks}{GitHub Link}}
      {\hfill \expandafter\href\expandafter{\the\cytoks}{#4}}
  }\par
  \ifthenelse{\equal{\compress}{0}}
  {}
  {\rItemizeSkip} % If uncommented, uncomment the one also in {rItemize}
}{}

% How to use:
\iffalse
  \begin{rProjects}{Project name}{Achieved X\% growth for XYZ using A, B, and C skills/technologies.}
  \end{rProjects}

  \begin{rProjects}{Project name}{Description.}
    \begin{rItemize}
      \ritem Achieved X\% As Measured by Y by using/doing Z.
      \ritem Achieved X\% growth for XYZ using A, B, and C skills/technologies.
      \ritem Led XYZ which led to X\% of improvement in ABC.
      \ritem Developed XYZ that did A, B, and C using X, Y, and Z.
      \ritem Leveraged knowledge X, Y, Z.
    \end{rItemize}
  \end{rProjects}

  \begin{rProjects}{Project name}{Description.}
    [https://github.com/OmarShawky1/CS-Roadmap#projects]
    []
    \begin{rItemize}
      \ritem Same as above.
    \end{rItemize}
  \end{rProjects}

  \begin{rProjects}{Project name}{Description}
    [https://github.com/OmarShawky1/CS-Roadmap#projects]
    [Project Link] % Replace "Project Link" with the name you want
    \begin{rItemize}
      \ritem Same as above.
    \end{rItemize}
  \end{rProjects}
\fi

%----------------------------------------------------------------------------------------
% Table Environments (Designed mainly for Skills Section)
%----------------------------------------------------------------------------------------
\newenvironment{rTable}{
  % To change style, just replace rTable2 with the other style
  \begin{rTable1}
}{
  \end{rTable1}
}

%----------------------------------------------------------------------------------------
% Implementation

% Table constants (For all tables)
\FPeval\arraystretch{1.6 * \decompress}
% y2 = 6ex, y1 = 2ex
% x2 = 0.7, x1 = 1
% y = 40/3x - 22/3
\FPeval\tabspace{(40/3) * \decompress - 22/3} % Calculate table spacing based on compression setting, currently not used

% Default Table
% Modern table implementation (Ubuntu 22.04+ compatible and 2021 latexmk kernel version or later)
% Author/Source: https://tex.stackexchange.com/a/740124/296109
% \RequirePackage{tabularray}
% \UseTblrLibrary{booktabs}
\DeclareTblrTemplate{caption-tag}{twotblr}{}
\DeclareTblrTemplate{caption-sep}{twotblr}{}
\DeclareTblrTemplate{caption-text}{twotblr}{}
\DeclareTblrTemplate{contfoot-text}{twotblr}{}
\DeclareTblrTemplate{conthead-text}{twotblr}{}

\newenvironment{rTable1}{
  \vspace{-\baselineskip}
  \SetTblrTemplate{contfoot-text}{twotblr}
  \SetTblrTemplate{conthead-text}{twotblr}
  \SetTblrTemplate{caption-tag}{twotblr}
  \SetTblrTemplate{caption-text}{twotblr}
  \SetTblrTemplate{caption-sep}{twotblr}
  \begin{longtblr}{
    colspec = {@{}lX@{}}, % Add @{} to remove padding on both sides
    width = \textwidth,
    column{1} = {font=\bfseries},
    column{2} = {halign=l}, % Set the second column to hard wrap
    stretch = 1,
    % rowhead = 1, % set first row as header and enforces you to create at least two rows even if the second is an empty line
  }
}{
  \end{longtblr}
  \vspace{-1.7\baselineskip}
}

% Legacy table implementation (Ubuntu 20.04 compatible and 2020 latexmk kernel version or earlier)
% Deprecated, but kept for future reference
% Note: Before using this, make sure to comment out the rTable1 packages in the preamble and all "\DeclareTblrTemplate" commands, and uncomment the rTable2 packages in the preamble.
% \RequirePackage{longtable}
% \RequirePackage{tabu}
\newenvironment{rTable2}{
  \vspace{-\baselineskip}
  \begin{longtabu} to \textwidth {
    @{} % No space at start of row
    >{\bfseries}l % First column: bold left-aligned
    % @{\extracolsep{\tabspace ex}} % Extra space between columns, incompatabile (can't be used) with 2020 compilers
    @{\ifthenelse{\equal{\compress}{100}}{\hspace{2ex}}{\hspace{6ex}}} % Space between columns based on compression setting
    X[l] % Second column expanded and left-aligned
    @{} % No space at end of row
  }
}{
  \end{longtabu}
  \vspace{-1.7\baselineskip}
}

% For a special case table where it shouldn't be on multiple pages
% Deprecated like rTable2, but kept for future reference
\newenvironment{rTable3}{
  \begin{longtabu} to \textwidth {
    @{} | >{\centering\arraybackslash}m{0.22\textwidth} | >{\centering\arraybackslash}m{0.22\textwidth} | >{\centering\arraybackslash}m{0.22\textwidth} | >{\centering\arraybackslash}m{0.22\textwidth} | @{}
  }
  \hline
}{
  \hline
  \end{longtabu}
  \vspace{
    -
    1.7
    \baselineskip}
}

%----------------------------------------------------------------------------------------
% Recommendation Environments
%----------------------------------------------------------------------------------------
\NewDocumentEnvironment{recommendation}{m m m}{
  % To change style, just replace recommendation1 with the other style
  \begin{recommendation1}{#1}{#2}{#3}
  \end{recommendation1}
}{}

% How to use
\iffalse
  \begin{recommendation}
    {Text}
    {Author}
    {Role}
  \end{recommendation}
\fi

%-----------------------------------------------------------------------------------------
% Implementation

% Implementation 1
\NewDocumentEnvironment{recommendation1}{m m m}{%
  \textit{\textquotedblleft{#1}\textquotedblright}\\
  -\textbf{#2}, \textit{#3}
}{}

% Implementation 2
% \RequirePackage{amsmath}
% \RequirePackage{mdframed}
\NewDocumentEnvironment{recommendation2}{m m m}{
  \vspace{\baselineskip}
  \begin{siderules}
    \textit{\textquotedblleft{#1}\textquotedblright}
  \end{siderules}
  --\textbf{#2}, \textit{#3}
}{}

\newmdenv[
  topline=false,
  bottomline=false,
  rightline=false,
  skipabove=\topsep,
  skipbelow=\topsep
]{siderules}

%----------------------------------------------------------------------------------------
% Publications Environment
%----------------------------------------------------------------------------------------
% \RequirePackage[numbers]{natbib} % numbers for numbering style
\newcommand*{\rPublications}[1]{
  % For future, environment can be replaced with:
  % \sectionHeading{Publications} % Section title
  \begin{rSection}{Publications}
    \renewcommand{\refname}{\vspace{-1.25\baselineskip}} % Redefine \refname to suppress "References" and remove extra huge text line space
    \nocite{*}
    \bibliographystyle{unsrtnat}
    \bibliography{#1}
  \end{rSection}
}

% How to use:
\iffalse
  \rPublications{publications} % 'publications' is the name of a BibTeX file
\fi

\iffalse
  \NewDocumentEnvironment{publications}{}{
    \patchcmd{\thebibliography}{\section*{\refname}}{}{}{}
    \nocite{*}
    \bibliographystyle{unsrt}
    \bibliography{publications}    % 'publications' is the name of a BibTeX file
  }{}

  % How to use
  \begin{rSection}{Publications}
    \begin{publications}
    \end{publications}
  \end{rSection}
\fi

%----------------------------------------------------------------------------------------
% Implementations

% Documentation
% 1. Create a publications.bib file.
% 2. Use the following template to fill for each publication:
% @article{citationkey,
%   title={Title},
%   author={Author},
%   journal={Journal},
%   pages={123456},
%   year={2020},
%   publisher={Publisher Name}
% }

%----------------------------------------------------------------------------------------
% Itemize Environment
%----------------------------------------------------------------------------------------
% New rItemize to compress points if needed in the future
% 1 optional argument, Bullet points Heading, Don't use with {rProjects} as it handles heading differently and it should be merged with this.
\NewDocumentEnvironment{rItemize}{o}{
  \IfValueT{#1}{
    \textbf{#1}
    }
  \ifthenelse{\equal{\compress}{100}}
  {
    \begin{itemize}
      [
      leftmargin=0.16in, % Set the left margin to 0.16 inch
      align=left, % Align the text with the left edge
      labelsep=-8pt, % Space between bullet point and text
      itemindent=0pt, % No additional indentation for the item
      itemsep=0pt, % No additional space between items
      parsep=0pt, % No additional space between paragraphs within an item
    ]
  }
  {
    \begin{itemize}
  }
}{
  \raggedright
  \end{itemize}
}

% How to use:
\iffalse
  \begin{rItemize}
    \item Learns \& adapts fast.
  \end{rItemize}

  \begin{rItemize}[What he excels at:]
    \item Learns \& adapts fast.
  \end{rItemize}
\fi

%----------------------------------------------------------------------------------------
% rHItemize Environment
%----------------------------------------------------------------------------------------
% This is not used at all because it is ugly but kept just in case
% It is better to use comma separated values.
% Some people might favor it because it displays items more clearly
% \RequirePackage[inline]{enumitem}
% \RequirePackage{multicol}
\newenvironment{rHItemize}{
  \begin{multicols}{4} % adjust the number for the number of columns you want
    \begin{itemize}
}{
    \end{itemize}
  \end{multicols}
}

\newcommand*{\inlineitem}[1]{\item #1}

\iffalse
  % How to use:
  \begin{rHItemize}
    \inlineitem Item 1
    \inlineitem Item 2
    \inlineitem Item 3
    \inlineitem Item 4
    \inlineitem Item 5
    \inlineitem Item 6
    \inlineitem Item 7
    \inlineitem Item 8
    \inlineitem Item 9
  \end{rHItemize}
\fi

%----------------------------------------------------------------------------------------
%	Job Description Echo (for ATS)
%----------------------------------------------------------------------------------------
% Untested and may cause harm
% \RequirePackage{adjustbox}
\NewDocumentCommand{\ATS}{+v}{
  \begingroup
    \color{white}
    \fontsize{1pt}{1pt}\selectfont
    \parskip=0pt
    \def\par{} % Escape new paragraph using new lines
    \begin{adjustbox}{minipage=\textwidth,scale=0.2} % Adjust the width and scale as needed
      #1 % Escape all special characters
    \end{adjustbox}
  \endgroup
}

% ----------------------------------------------------------------------------------------
% Unimportant features but added via AI
% ----------------------------------------------------------------------------------------

% Class Finalization
% Issue warnings for deprecated commands
\AtBeginDocument{%
  \@ifundefined{@name}{%
    \ClassWarning{resume}{No name specified. Use \string\name{Your Name}}%
  }{}%
}

\endinput