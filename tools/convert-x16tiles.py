import sys
from PIL import Image

def main():
    infilename = ""
    outfilename = ""
    tilew = 0
    tileh = 0

    # Parse command line options
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-in":
            i += 1
            infilename = sys.argv[i]
        elif sys.argv[i] == "-out":
            i += 1
            outfilename = sys.argv[i]
        elif sys.argv[i] == "-tilew":
            i += 1
            tilew = int(sys.argv[i])
        elif sys.argv[i] == "-tileh":
            i += 1
            tileh = int(sys.argv[i])

    # Convert to uppercase
    u = infilename.upper()
    infilename = u

    u = outfilename.upper()
    outfilename = u

    # Debug Variables
    print("Input File Name:  " + infilename)
    print("Output File Name:  " + outfilename)

    # Open source image
    srcimg = Image.open(infilename)

    # Calculate total number of tiles
    num_tiles = (int(srcimg.width / tilew)) * (int(srcimg.height / tileh))

    # Calculate destination image height
    dstheight = num_tiles * tileh

    # Create new image using destination height
    dstimg = Image.new('RGB', (tilew,dstheight))

    x = 0
    y = 0
    dst_h = 0

    while dst_h < (dstheight - 1):
        cropped = srcimg.crop((x, y, x + tilew, y + tileh))
        dstimg.paste(cropped, (0, dst_h))
        dst_h += tileh
        x += tilew
        if x > srcimg.width:
            y += tileh
            x = 0
        
    srcimg.close()
    dstimg.save(outfilename)

if __name__ == "__main__":
    main()
