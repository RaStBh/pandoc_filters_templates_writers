REM .bat-file to create from one .md-file the various output files (plain, html, 
REM pdf, ...).
REM
REM Copyright (C) 2021 Ralf Stephan (RaSt) <me@ralf-stephan.name>
REM
REM RaSt mod_ecl is free software: you can redistribute it and/or modify it under
REM the terms of the GNU General Public License as published by the Free Software
REM Foundation, either  version 3 of the  License, or (at your  option) any later
REM version.
REM
REM RaSt mod_ecl is distributed  in the hope that it will  be useful, but WITHOUT
REM ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
REM FOR  A PARTICULAR  PURPOSE.   See the  GNU General  Public  License for  more
REM details.
REM
REM You should have received a copy of  the GNU General Public License along with
REM this     program     in     the     file    COPYING.      If     not,     see
REM <https://www.gnu.org/licenses/>.



echo make.bat log file: > .\make.log
echo. >> .\make.log



if exist .\make.log (
  >>.\make.log 2>&1 (
    echo --------------------------------------------------------------------------------
    echo %DATE%%TIME%
    echo --------------------------------------------------------------------------------
    echo.
  )
) else (
  copy NUL .\make.log
)



>>.\make.log 2>&1 (
  echo native:
  echo.
)




>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --standalone ^
    --data-dir=.\data_dir\ ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=native ^
    --output=.\native\native.pandoc ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo txt:
  echo.
)



REM allowed extensions:
REM   pandoc_title_block
REM   yaml_metadata_block
REM not allowed extensions:

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
  --toc-depth=4 ^
    --data-dir=.\data_dir\ ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=.\data_dir\writers\rast-plain.lua ^
    --lua-filter=.\data_dir\filter\rast-date.lua ^
    --lua-filter=.\data_dir\filter\rast-toc.lua ^
    --template=rast-plain.lua ^
    --output=.\plain\ptsg.txt ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo html:
  echo.
)



REM requires a nonempty <title> element.
REM
REM allowed extensions:
REM not allowed extensions:
REM   pandoc_title_block
REM   yaml_metadata_block

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=html5 ^
    --lua-filter=.\data_dir\filter\rast-toc.lua ^
    --output=.\html\ptsg.html ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo docbook:
  echo.
)



REM allowed extensions:
REM   yaml_metadata_block
REM not allowed extensions:
REM   pandoc_title_block

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=docbook5 ^
    --output=.\docbook\ptsg.xml ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo latex:
  echo.
)



REM allowed extensions:
REM not allowed extensions:
REM   pandoc_title_block
REM   yaml_metadata_block

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=latex ^
    --output=.\latex\ptsg.ltx ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo context:
  echo.
)



REM allowed extensions:
REM   yaml_metadata_block
REM not allowed extensions:
REM   pandoc_title_block

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=context ^
    --output=.\context\ptsg.ctx ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo pdf:
  echo.
)



REM allowed extensions:
REM not allowed extensions:
REM   pandoc_title_block
REM   yaml_metadata_block

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from=commonmark_x ^
    --to=pdf ^
    --bibliography=".\ptsg.bib" ^
    --output=.\pdf\ptsg.pdf ^
    .\ptsg.md
  echo.
)



>>.\make.log 2>&1 (
  echo markdown to html with citations:
  echo.
)



REM allowed extensions:
REM not allowed extensions:

>>.\make.log 2>&1 (
  "C:\Program Files\Pandoc\pandoc.exe" ^
    --defaults=.\ptsg.conf ^
    --from="markdown+citations" ^
    --to=html ^
    --output=.\md_to_html\ptsg.html ^
    --citeproc ^
    --biblatex ^
    --bibliography=".\ptsg.bib" ^
    --csl=".\csl\ieee-with-url.csl" ^
    .\ptsg.md
  REM echo.
)
