import sys

def usage():
    print("Usage: python convert-pal.py -in <input file> -out <output file>")
    
def main():
    infilename = ""
    outfilename = ""

    # Parse command line argument
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-in":
            i += 1
            infilename = sys.argv[i]
        elif sys.argv[i] == "-out":
            i += 1
            outfilename = sys.argv[i]

    # We need an input file, and an output file for this script to work
    if infilename == "" or outfilename == "":
        usage()
        return
    
    # Convert to uppercase
    u = infilename.upper()
    infilename = u

    u = outfilename.upper()
    outfilename = u

    # Debug Variables
    print("Input File Name:  " + infilename)
    print("Output File Name:  " + outfilename)

    # Open input file
    try:
        f = open(infilename, "rb")
    except:
        print("ERROR:  Could not open input file " + infilename + "!!")
        return
    
    try:
        o = open(outfilename, "wb")
    except:
        print("ERROR: Could not open output file " + outfilename + "!!")
        f.close()
        return
    
    ba = bytearray()
    ba.append(0)
    ba.append(0)

    while True:
        color = f.read(3)
        if not color:
            break;

        # r = 0, g = 1, b = 2 (indices)
        # 0xFF
        b = (int(color[2]) & 0xF0) >> 4         # 0x0F
        g = (int(color[1]))                     # 0xF0
        gb = g | b                              # 0xFF

        r = (int(color[0]) & 0xF0) >> 4         # 0x0F

        ba.append(gb)
        ba.append(r)
    
    by = bytes(ba)
    o.write(by)

    o.close()
    f.close()
    
if __name__ == "__main__":
    main()
