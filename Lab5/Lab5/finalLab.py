import math
import argparse
import random

# ----------------------------
# Cache Line
# ----------------------------
class CacheLine:
    def __init__(self):
        self.tag = None
        self.val = None
        self.use = -1     # used for LRU


# ----------------------------
# Main Cache Simulator
# ----------------------------
class CacheSimulator:
    DIRECT = 0
    RANDOM = 1
    LRU = 2

    def __init__(self, assoc, block_size, block_amt, policy, verbose):
        self.assoc = assoc
        self.block_size = block_size
        self.block_amt = block_amt
        self.policy = policy
        self.verbose = verbose

        self.offset_bits = int(math.log2(block_size))
        self.index_bits = int(math.log2(block_amt))

        # 2D array: [way][set]
        self.cache = [
            [CacheLine() for _ in range(block_amt)]
            for _ in range(assoc)
        ]

    # ----------------------------
    # Convert address → tag/index/offset
    # ----------------------------
    def break_address(self, addr):
        offset = addr & ((1 << self.offset_bits) - 1)
        addr >>= self.offset_bits

        index = addr & ((1 << self.index_bits) - 1)
        addr >>= self.index_bits

        tag = addr
        return tag, index, offset

    # ----------------------------
    # Perform lookup
    # ----------------------------
    def access(self, addr):
        tag, index, offset = self.break_address(addr)

        # HIT?
        for way in range(self.assoc):
            if self.cache[way][index].tag == tag:
                # update LRU "use" counters
                if self.policy == self.LRU:
                    for w in range(self.assoc):
                        if self.cache[w][index].use > 0:
                            self.cache[w][index].use -= 1
                    self.cache[way][index].use = self.assoc
                return True

        # MISS → insert based on replacement policy
        self.replace_line(tag, index, addr)
        return False

    # ----------------------------
    # Replacement policy
    # ----------------------------
    def replace_line(self, tag, index, full_addr):
        if self.policy == self.DIRECT:
            line = self.cache[0][index]
            line.tag = tag
            line.val = full_addr

        elif self.policy == self.RANDOM:
            way = random.randrange(self.assoc)
            line = self.cache[way][index]
            line.tag = tag
            line.val = full_addr

        elif self.policy == self.LRU:
            # find empty way (use == -1)
            for way in range(self.assoc):
                if self.cache[way][index].use == -1:
                    self.cache[way][index].tag = tag
                    self.cache[way][index].val = full_addr
                    self.cache[way][index].use = self.assoc

                    # decrement others
                    for w in range(self.assoc):
                        if self.cache[w][index].use > 0:
                            self.cache[w][index].use -= 1
                    return

            # otherwise replace LRU (use == 0)
            for way in range(self.assoc):
                if self.cache[way][index].use == 0:
                    self.cache[way][index].tag = tag
                    self.cache[way][index].val = full_addr
                    self.cache[way][index].use = self.assoc
                else:
                    self.cache[way][index].use -= 1

    # ----------------------------
    # Optional verbose cache print
    # ----------------------------
    def print_cache(self):
        for way in range(self.assoc):
            row = [self.cache[way][i].val for i in range(self.block_amt)]
            print(f"{way}: {row}")


# ----------------------------
# Run simulation from file
# ----------------------------
def run_simulator(filename, assoc, block_size, block_amt, policy, verbose):

    sim = CacheSimulator(assoc, block_size, block_amt, policy, verbose)

    hits = 0
    misses = 0

    with open(filename, "r") as f:
        for line in f:
            hex_addr = line.strip()
            if hex_addr == "":
                continue

            addr = int(hex_addr, 16)

            if sim.access(addr):
                hits += 1
            else:
                misses += 1

    # Results
    total = hits + misses
    print(f"hits: {hits}, misses: {misses}")
    print(f"hit rate:  {100 * hits / total:.2f}%")
    print(f"miss rate: {100 * misses / total:.2f}%")

    if verbose:
        print("\nFinal Cache State:")
        sim.print_cache()


# ----------------------------
# Command-line Interface
# ----------------------------
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Python Cache Simulator")

    parser.add_argument("file", help="input file of hex addresses")
    parser.add_argument("-assoc", required=True, type=int)
    parser.add_argument("-blocksize", required=True, type=int)
    parser.add_argument("-blockamt", required=True, type=int)
    parser.add_argument("-policy", required=True, type=int,
                        help="0=direct, 1=random, 2=LRU")
    parser.add_argument("-v", type=int, default=0)

    args = parser.parse_args()

    run_simulator(args.file, args.assoc, args.blocksize,
                  args.blockamt, args.policy, args.v)
