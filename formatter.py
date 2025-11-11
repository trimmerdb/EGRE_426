# formatter.py

def format_rom(input_file="input.txt", output_file="output.txt"):
    with open(input_file, "r") as infile:
        lines = [line.strip() for line in infile if line.strip()]

    with open(output_file, "w") as outfile:
        index = 0
        for i, value in enumerate(lines):
            outfile.write(f"{index} => \"{value}\",\n")
            index += 1
            # Insert a zero-filled instruction between each
            if i != len(lines) - 1:
                outfile.write(f"{index} => \"0000000000000000\",\n")
                index += 1

    print(f"Formatted {len(lines)} instructions into {output_file}")

if __name__ == "__main__":
    format_rom()
