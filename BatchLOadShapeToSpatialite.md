Ciao Ugo, 

you are absolutely free to create a single DB-file containing an 
impressively high number of GeoTables: sometimes I've personally 
tested some DB containing several hundreds GeoTables and anything 
worked in the smoothest way. 

basically you can choose between two possible alternative ways 
in order to load one or more Shapefiles into some DB-file. 

1. you can use the SpatiaLite GUI tool; it directly supports 
    an user friendly "load Shapefile" dialog, so you simply 
    have to repeatedly call it once for each SHP to be imported. 
    this surely is the easiest and more intuitive way, but it 
    could quickly become boring if you have to import many 
    tenth or hundredth shapefiles. 

2. you can use the shell and the CLI tool; in this case 
    writing some SQL script can effectively help to simply 
    and automate the whole process. A SQL script just is 
    a plain text file, so you can easily write and check 
    your own script by using any text editor. 

step#1: 
========================================================== 
write your SQL script, something like this: 

-- 
-- initializing all spatial metadata tables 
-- 
`SELECT InitSpatialMetadata(1); `

-- 
-- importing the first SHP (buildings) 
-- 
`SELECT ImportSHP('C:/myshapes/buildings', 'buildings', 
        'CP1252', 3003); `

-- 
-- importing a second SHP (roads) 
-- 
SELECT ImportSHP('C:/myshapes/roads', 'roads', 
        'CP1252', 3003); 

-- 
-- importing a third SHP (railways) 
-- 
SELECT ImportSHP('C:/myshapes/railways', 'railways', 
        'CP1252', 3003); 

a. lines starting with two hyphens simply are comments 
b. the ImportSHP() SQL function will attempt to import 
    an external Shapefile 
c. the first argument passed to ImportSHP() is the absolute 
    or relative path of the Shapefile (note well: you must 
    omit any .shp, .shx or .dbf suffix) 
d. the second argument is the name of the DB table to 
    be created 
e. the third argument is the charset encoding adopted by 
    the SHP; I'm assuming that your Shapefiles have been 
    very probably created on Windows in Italy, so CP1252 
    aka Windows Latin 1 should be the most probable setting. 
f. and finally the fourth argument is the SRID; I'm 
    assuming 3003 aka Monte Mario / Italy zone 1 
g. usually SQL scripts are identified by a ".sql" suffix, 
    but it's not a strict mandatory requirement. 


step#2: 
========================================================== 
executing the SQL script. 
just open a command shell and type: 

export "SPATIALITE_SECURITY=relaxed" 
spatialite mynewdb.sqlite <mysqlscript.sql 

a. first you have to set the environment 
    variable SPATIALITE_SECURITY so to enable 
    the CLI tool to access local files. 
b. then you simply have to launch the CLI 
    tool by passing the path of the DB-file 
    to be opened/created; the SQL script will 
    simply be assigned as the standard input file. 

NOTE: 
if you are working on a Windows platform and not 
on Linux the syntax required in order to set an 
environment variable is slightly different: 

SET SPATIALITE_SECURITY=relaxed 
spatialite mynewdb.sqlite <mysqlscript.sql 

bye Sandro 
