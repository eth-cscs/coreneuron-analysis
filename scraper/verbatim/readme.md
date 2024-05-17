Some python scripts for analyzing the modelDB database. Requires Python 2.7.

###`download.py`
Download all of the projects in individual zip files. Scrapes the html file `modldb.html`. To get the most up to date version of the database, you will have to replace the html file from that on the web site.

###`project_stats.py`
Some simple statistics about the number of projects with NMODL files and VERBATIM blocks therein.

###`parse_zips.py`
Lists the projects, ordered by those with the most VERBATIM blocks.
Then it prints out all of the unique VERBATIM blocks for all projects.
By default it prints all projects.

#### single project
To print the VERBATIM blocks for only the project ranked 10
```
python2.7 parser_zips.py 10
```


#### range of projects
To print the VERBATIM blocks for projects ranked 10:15 inclusive:
```
python2.7 parser_zips.py 10 15

```

