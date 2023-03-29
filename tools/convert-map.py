import sys
import xml.etree.ElementTree as ET

def usage():
    print("Usage: python convert-map.py -in <input file> -out <output file> -terrain <terrain layer name>")

def main():
    infilename = ""
    outfilename = ""

    # terrain export
    terrain_layer_name = ""
    terrain_file_name = ""
    terrain_firstgid = 0
    terrain_tsx = ""

    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-in":
            i += 1
            infilename = sys.argv[i]
        elif sys.argv[i] == "-out":
            i += 1
            outfilename = sys.argv[i]
        elif sys.argv[i] == "-terrain":
            i += 1
            terrain_layer_name = sys.argv[i]
        elif sys.argv[i] == "-?" or sys.argv[i] == "-help":
            usage()
            return
        
    # We need a terrain layer name, an input file, and an output file for this script to work
    if terrain_layer_name == "" or infilename == "" or outfilename == "":
        usage()
        return
    
    # Convert to uppercase
    u = infilename.upper()
    infilename = u

    u = outfilename.upper()
    outfilename = u

    # Create Terrain output file name
    terrain_file_name = outfilename + ".TER"
    print("Terrain File Name:  " + terrain_file_name)

    print("")
    # Debug Variables
    print("Input File Name:  " + infilename)
    print("Output File Name:  " + outfilename)

    tree = ET.parse(infilename)
    root = tree.getroot()
    print("Root = " + root.tag)

    for child in root:
        if child.tag == "tileset":
            terrain_tsx = child.get("source")
            terrain_firstgid = int(child.get("firstgid"))
        elif child.tag == "layer":
            if child.get("name") == terrain_layer_name:
                export_terrain_layer(child, terrain_file_name, terrain_firstgid)
    
    print("Terrain Tileset:  " + terrain_tsx)
    print("Tileset First GID:  " + str(terrain_firstgid))
    
    return

def export_terrain_layer(c, terrain_file, firstgid):
    print("Exporting tile layer:  " + c.get("name"))

    mapdata = c.find("data").text.replace("\n", "").split(",")
    
    try:
        o = open(terrain_file, "wb")
    except:
        print("ERROR:  Could not open output file + " + terrain_file + "!!")
        return
    
    b = bytearray()
    b.append(0)
    b.append(0)

    for i in range(len(mapdata)):
        m = int(mapdata[i])
        if m > 0:
            m = m - firstgid

        if m > 255:
            o1 = m & 0x00FF             # Low byte
            o2 = (m & 0xFF00) >> 8      # High byte
            b.append(o1)
            b.append(o2)
        elif m <= 255:
            b.append(m)
            b.append(0)

    ba = bytes(b)
    o.write(ba)
    o.close()
    


if __name__ == "__main__":
    main()
