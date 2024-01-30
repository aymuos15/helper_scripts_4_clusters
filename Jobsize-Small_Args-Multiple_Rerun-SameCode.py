import subprocess

# List of case IDs and corresponding output file paths
cases = [
    ("<arg1>", "<arg2>"),
    ("<arg1>", "<arg2>"),
    # ...
]

# Iterate over the list of cases
for case_id, output_file in cases:
    # Construct the command to run the script with arguments
    command = ["python", "<path_to_script>", <arg1>, <arg2>]

    result = subprocess.run(command, capture_output=True, text=True)
    
    # Execute the command
    print(result.stdout)

'''
In the case of:
Jobsize: Small (Can fit in one node)
Args: Multiple
Rerun: Same Code
'''

'''
Way more beneficial than creating multiple jobs
'''
