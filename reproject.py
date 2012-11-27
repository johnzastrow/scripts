# ---------------------------------------------------------------------------
# reproject.py
# Created on: Thu Jul 16 2009 04:50:37 PM
#   (generated by ArcGIS/ModelBuilder)
# ---------------------------------------------------------------------------

# Import system modules
import sys, string, os, arcgisscripting

# Create the Geoprocessor object
gp = arcgisscripting.create()

# Load required toolboxes...
gp.AddToolbox("C:/Documents and Settings/john.zastrow/Application Data/ESRI/ArcToolbox/My Toolboxes/JohnsFavs.tbx")


# Local variables...
DiverKelpExtents2 = "F:\\PENDELTON_KELP\\VectorsWGS84.gdb\\DiverKelpExtents2"
DiverKelpExtents = "F:\\PENDELTON_KELP\\Vectors.gdb\\DiverKelpExtents"

# Process: Project...
gp.toolbox = "C:/Documents and Settings/john.zastrow/Application Data/ESRI/ArcToolbox/My Toolboxes/JohnsFavs.tbx";
gp.Project(DiverKelpExtents, DiverKelpExtents2, "GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]]", "", "PROJCS['WGS_1984_UTM_Zone_11N',GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Transverse_Mercator'],PARAMETER['False_Easting',500000.0],PARAMETER['False_Northing',0.0],PARAMETER['Central_Meridian',-117.0],PARAMETER['Scale_Factor',0.9996],PARAMETER['Latitude_Of_Origin',0.0],UNIT['Meter',1.0]]")

