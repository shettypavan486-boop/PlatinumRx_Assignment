# PlatinumRx Assignment - Python 

# Q1: Given number of minutes, convert to human readable form
def convert_minutes(total_minutes):
    """
    Converts integer minutes to a human-readable string.
    Example: 130 → "2 hrs 10 minutes"
    """
    hours             = total_minutes // 60   # integer division
    remaining_minutes = total_minutes % 60    # modulo remainder

    if hours == 0:
        return f"{remaining_minutes} minutes"
    elif remaining_minutes == 0:
        return f"{hours} hrs"
    else:
        return f"{hours} hrs {remaining_minutes} minutes"


# Test Cases 
if __name__ == "__main__":
    tests = [130, 110, 60, 0, 59, 90, 200, 75]
    for mins in tests:
        print(f"{mins} minutes  →  {convert_minutes(mins)}")
