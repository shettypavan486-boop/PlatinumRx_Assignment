# PlatinumRx Assignment - Python 

# Q2: Remove duplicate characters from a string using a loop
def remove_duplicates(input_string):
    result = ""                     

    for char in input_string:       
        if char not in result:       
            result += char           

    return result


# Test Cases
if __name__ == "__main__":
    tests = ["programming", "hello", "aabbcc", "abcdef", "data analyst"]
    for s in tests:
        print(f"Input:  {s}")
        print(f"Output: {remove_duplicates(s)}")
        print()