@echo off
cd bugs
echo ^<!DOCTYPE html^> > bugtracker.html
echo ^<html^> >> bugtracker.html
echo ^<head^> >> bugtracker.html
echo 	^<meta charset="utf-8"^> >> bugtracker.html
echo 	^<link rel="stylesheet" type="text/css" href="style.css"^> >> bugtracker.html
echo 	^<title^>bugtracker^</title^> >> bugtracker.html
echo ^</head^> >> bugtracker.html
echo ^<body^> >> bugtracker.html
echo ^<article class="markdown-body"^> >> bugtracker.html

perl Markdown.pl --html4tags ../bugs-list.md >> bugtracker.html

echo ^</article^> >> bugtracker.html
echo ^</body^> >> bugtracker.html
echo ^</html^> >> bugtracker.html

bugtracker.html