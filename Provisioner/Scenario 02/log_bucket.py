import sys

bucket = sys.argv[1]
with open("output/buckets.log", "a") as f:
    f.write(f"New bucket created: {bucket}\n")

print("Bucket logged successfully.")