# ------------------------------------------------------------
# cache_sim.py
#   Simple cache simulator for word-addressed accesses.
#   Supports:
#       - Direct mapped (associativity = 1)
#       - N-way set associative caches
#       - LRU replacement
#
#   Grading validation example included at bottom.
# ------------------------------------------------------------

class Cache:
    def __init__(self, num_words, associativity):
        """
        num_words      = total number of words in cache
        associativity  = number of ways per set
        block_size     = 1 word (fixed by assignment)
        """
        self.block_size = 1
        self.num_blocks = num_words
        self.assoc = associativity
        self.num_sets = num_words // associativity

        # For each set, maintain a list of tags (newest at end = most recently used)
        self.sets = [[] for _ in range(self.num_sets)]

    def access(self, address):
        """
        address: word address (NOT byte address)
        Returns: "HIT" or "MISS"
        """
        block_num = address  # 1 word per block
        set_index = block_num % self.num_sets
        tag = block_num      # Tag is simply block_num since word blocks

        the_set = self.sets[set_index]

        # HIT
        if tag in the_set:
            # Move element to end (most recent)
            the_set.remove(tag)
            the_set.append(tag)
            return "HIT"

        # MISS
        if len(the_set) < self.assoc:        # space available
            the_set.append(tag)
        else:                                # evict LRU
            the_set.pop(0)                   # remove oldest
            the_set.append(tag)

        return "MISS"

    def print_final_contents(self):
        print("Final cache contents by set (each entry = tag = word address):")
        for i, s in enumerate(self.sets):
            print(f"  Set {i}: {s}")


# ------------------------------------------------------------
# Function for running a simulation
# ------------------------------------------------------------
def run_sim(address_list, num_words, associativity, label):
    print("\n===============================")
    print(label)
    print("===============================\n")

    cache = Cache(num_words=num_words, associativity=associativity)

    results = []
    for addr in address_list:
        result = cache.access(addr)
        results.append(result)
        print(f"{addr}: {result}")

    print("\nSummary (hits/misses):")
    print(", ".join(results))

    print()
    cache.print_final_contents()


# ------------------------------------------------------------
# Grading Example (required to produce exact results)
# ------------------------------------------------------------
if __name__ == "__main__":
    # Word addresses given by assignment
    example = [0, 3, 11, 16, 21, 11, 16, 48, 16]

    # Part (a): Direct mapped, 1-way, 16 words total
    run_sim(
        address_list=example,
        num_words=16,
        associativity=1,
        label="Part (a): Direct-mapped cache, 16 words, 1-word blocks"
    )

    # Part (b): 2-way set associative, 16 words total
    run_sim(
        address_list=example,
        num_words=16,
        associativity=2,
        label="Part (b): 2-way set associative, LRU replacement"
    )
