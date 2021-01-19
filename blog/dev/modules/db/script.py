import subprocess
import os

processGit = subprocess.Popen(['git', 'rev-parse','--short', 'HEAD'], shell=False, stdout=subprocess.PIPE)
git_head_hash = processGit.communicate()[0].strip()

# os.environ['IVER'] = git_head_hash
bashCommand = 'export IVER='+git_head_hash
processBash = subprocess.Popen(['export', 'IVER', '=', git_head_hash], shell=False, stdout=subprocess.PIPE)
output, error = processBash.communicate()

# export IVER=$(python script.py)