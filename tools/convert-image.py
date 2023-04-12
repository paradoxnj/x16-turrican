import sys

MODE_1BPP = 1
MODE_2BPP = 2
MODE_4BPP = 4
MODE_8BPP = 8

def main():
    infilename = ""
    outfilename = ""
    mode = MODE_8BPP

    # Parse command line options
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-in":
            i += 1
            infilename = sys.argv[i]
        elif sys.argv[i] == "-out":
            i += 1
            outfilename = sys.argv[i]
        elif sys.argv[i] == "-mode":
            i += 1
            mode = int(sys.argv[i])
        
    # Convert to uppercase
    u = infilename.upper()
    infilename = u

    u = outfilename.upper()
    outfilename = u

    # Debug Variables
    print("Input File Name:  " + infilename)
    print("Output File Name:  " + outfilename)

    # Open the input file
    print("Opening input file:  " + infilename)
    try:
        in_f = open(infilename, "rb")
    except:
        print("ERROR:  Could not open input file " + infilename + "!!")
        return
    
    # Open the output file
    print("Opening output file:  " + outfilename)
    try:
        out_f = open(outfilename, "wb")
    except:
        print("ERROR:  Could not open output file " + outfilename + "!!")
        in_f.close()
        return
    
    m = int(mode)
    if m == MODE_1BPP:
        print("Converting to 1BPP")
        write_1bpp(in_f, out_f)
    elif m == MODE_2BPP:
        print("Converting to 2BPP")
        write_2bpp(in_f, out_f)
    elif m == MODE_4BPP:
        print("Converting to 4BPP")
        write_4bpp(in_f, out_f)
    elif m == MODE_8BPP:
        print("Converting to 8BPP")
        write_8bpp(in_f, out_f)

    out_f.close()
    in_f.close()

def write_1bpp(inf, outf):
    b = bytearray()
    b.append(0)
    b.append(0)

    while True:
        i = inf.read(8)
        if not i:
            break

        o = (int(i[0]) & 0x1) << 7          # 0x10000000
        o |= (int(i[1]) & 0x1) << 6         # 0x01000000
        o |= (int(i[2]) & 0x1) << 5         # 0x00100000
        o |= (int(i[3]) & 0x1) << 4         # 0x00010000
        o |= (int(i[4]) & 0x1) << 3         # 0x00001000
        o |= (int(i[5]) & 0x1) << 2         # 0x00000100
        o |= (int(i[6]) & 0x1) << 1         # 0x00000010
        o |= (int(i[7]) & 0x1)              # 0x00000000
        b.append(o)

    ba = bytes(b)
    outf.write(ba)

def write_2bpp(inf, outf):
    b = bytearray()
    b.append(0)
    b.append(0)

    while True:
        i = inf.read(4)
        if not i:
            break

        o = (int(i[0]) & 0x1) << 6          # 0x11000000
        o |= (int(i[1]) & 0x1) << 4         # 0x00110000
        o |= (int(i[2]) & 0x1) << 2         # 0x00001100
        o |= (int(i[3]) & 0x1)              # 0x00000011
        b.append(o)

    ba = bytes(b)
    outf.write(ba)

def write_4bpp(inf, outf):
    b = bytearray()
    b.append(0)
    b.append(0)

    while True:
        i = inf.read(2)
        if not i:
            break

        o = (int(i[0]) & 0xF) << 4          # 0x11110000
        o |= (int(i[1]) & 0xF)              # 0x00001111
        b.append(o)

    ba = bytes(b)
    outf.write(ba)

def write_8bpp(inf, outf):
    b = bytearray()
    b.append(0)
    b.append(0)

    while True:
        i = inf.read(2)
        if not i:
            break

        b.append(int(i[0]))
        b.append(int(i[1]))

    ba = bytes(b)
    outf.write(ba)

if __name__ == "__main__":
    main()
